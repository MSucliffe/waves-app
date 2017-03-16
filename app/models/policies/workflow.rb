class Policies::Workflow
  class << self
    def approved_name_required?(submission)
      return false if submission.part.to_sym == :part_3
      return false if submission.registered_vessel
      return false if submission.name_approval
      true
    end

    def generate_official_no?(submission)
      submission.part.to_sym != :part_3
    end

    def uses_port_no?(obj)
      Policies::Definitions.fishing_vessel?(obj)
    end
  end
end
