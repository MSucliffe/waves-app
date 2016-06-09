def error_message(field)
  t("activerecord.errors.models.registration.attributes.#{field}.accepted")
end

def path_for_step(step)
  registration_id = Registration.last.id
  step_string = I18n.t("wicked.#{step}")

  "/registration_wizard/#{step_string}?registration_id=#{registration_id}"
end

def complete_prerequisites_form(fields = default_prerequisites_form_fields)
  fill_form_and_submit(
    :registration,
    :update,
    fields
  )
end

def complete_vessel_info_form(fields = default_vessel_info_form_fields)
  complete_vessel_hin_field(fields)
  complete_vessel_length_in_centimeters_field(fields)

  fill_form_and_submit(
    :vessel,
    :update,
    fields
  )
end

def complete_vessel_hin_field(fields)
  hin = fields.delete(:hin)

  return if hin.blank?

  page.fill_in("hin[prefix]", with: hin[0..1])
  page.fill_in("hin[suffix]", with: hin[3..-1])
end

def complete_vessel_length_in_centimeters_field(fields)
  length_in_centimeters = fields.delete(:length_in_centimeters)

  return if length_in_centimeters.blank?

  metres = length_in_centimeters / 100
  centimetres = length_in_centimeters % 100

  page.fill_in("length_in_centimeters[m]", with: metres.to_s)
  page.fill_in("length_in_centimeters[cm]", with: centimetres.to_s)
end

def complete_owner_info_form
  click_on I18n.t("helpers.submit.registration.update")
end

def complete_declaration_form(fields = default_declaration_form_fields)
  fill_form_and_submit(
    :registration,
    :update,
    fields
  )
end

def default_prerequisites_form_fields
  {
    not_registered_before_on_ssr: true,
    not_registered_under_part_1: true,
    not_owned_by_company: true,
    not_commercial_fishing_or_submersible: true,
    owners_are_uk_residents: true,
    owners_are_eligible_to_register: true,
    not_registered_on_foreign_registry: true,
  }.freeze
end

def default_vessel_info_form_fields
  form_fields = attributes_for(:vessel, vessel_type: VesselType.all.sample)

  designation = form_fields[:vessel_type].designation.titleize
  form_fields[:vessel_type_id] = designation
  form_fields.delete(:vessel_type)

  form_fields
end

def default_declaration_form_fields
  {
    eligible_under_regulation_89: true,
    eligible_under_regulation_90: true,
    understands_false_statement_is_offence: true,
  }.freeze
end
