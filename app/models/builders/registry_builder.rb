class Builders::RegistryBuilder
  class << self
    def create(submission)
      @submission = submission

      Register::Vessel.transaction do
        init_vessel
        update_vessel_details
        assign_vessel_to_submission
        build_owners
        build_agent
      end

      @vessel
    end

    private

    def init_vessel
      @vessel = @submission.registered_vessel
      @vessel ||= Register::Vessel.new(part: @submission.part)
    end

    # rubocop:disable Metrics/AbcSize
    def update_vessel_details
      @vessel.name = @submission.vessel.name
      @vessel.hin = @submission.vessel.hin
      @vessel.make_and_model = @submission.vessel.make_and_model
      @vessel.length_in_meters = @submission.vessel.length_in_meters
      @vessel.number_of_hulls = @submission.vessel.number_of_hulls
      @vessel.mmsi_number = @submission.vessel.mmsi_number
      @vessel.radio_call_sign = @submission.vessel.radio_call_sign
      @vessel.vessel_type = @submission.vessel.type_of_vessel
      @vessel.name_approved_until = nil
      @vessel.save
    end

    def assign_vessel_to_submission
      unless @submission.registered_vessel
        @submission.update_attribute(:registered_vessel_id, @vessel.id)
      end
    end

    def build_owners
      @vessel.owners.delete_all
      @submission.owners.each { |owner| build_owner(owner) }
    end

    def build_owner(owner)
      @vessel.owners.create(
        name: owner.name, nationality: owner.nationality,
        email: owner.email, phone_number: owner.phone_number,
        address_1: owner.address_1, address_2: owner.address_2,
        address_3: owner.address_3,
        town: owner.town, postcode: owner.postcode,
        country: owner.country)
    end

    def build_agent
      return unless @submission.agent
      agent = @vessel.agent || @vessel.build_agent
      agent.name = @submission.agent.name
      agent.email = @submission.agent.email
      agent.phone_number = @submission.agent.phone_number
      agent.save
    end
  end
end
