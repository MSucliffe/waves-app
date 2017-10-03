class Report::TrinityHouseReport < Report
  def title
    "Part I"
  end

  def second_sheet_title
    "Part II"
  end

  def third_sheet_title
    "Part III"
  end

  def fourth_sheet_title
    "Part IV"
  end

  def results
    build_results(:part_1)
  end

  def second_sheet_results
    build_results(:part_2)
  end

  def third_sheet_results
    build_results(:part_3)
  end

  def fourth_sheet_results
    build_results(:part_4)
  end

  def headings
    [
      "Official number", "Port of registry", "Current registration status",
      "Task type", "Vessel Name", "Registered length",
      "Correspondent's name'", "Owner's name and address",
      "Date of registry", "Date of closure", "Reason for closure"
    ]
  end

  private

  def build_results(part)
    Submission
      .includes(:registration, :declarations)
      .in_part(part)
      .completed
      .where("completed_at >= ?", @date_start)
      .where("completed_at <= ?", @date_end)
      .map do |submission|
        assign_result(submission)
      end
  end

  # rubocop:disable all
  def assign_result(submission)
    vessel = submission.vessel
    registration = submission.registration || Registration.new

    Result.new(
      [
        submission.vessel_reg_no,
        vessel.port_name,
        RegistrationStatus.new(submission.registered_vessel).to_s,
        Task.new(submission.task).description,
        vessel.name,
        vessel.register_length,
        submission.correspondent.try(:name),
        submission.owners.map(&:inline_name_and_address).join("; "),
        registration.created_at,
        registration.closed_at,
        closure_reason(registration),
      ])
  end
  # rubocop:enable all

  def closure_reason(registration)
    return registration.description if registration.try(:closed_at?)
  end
end
