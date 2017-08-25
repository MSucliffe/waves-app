class Activity
  attr_reader :part

  PART_TYPES = [
    ["Part I", :part_1],
    ["Part II", :part_2],
    ["Part III", :part_3],
    ["Part IV", :part_4],
  ].freeze

  def initialize(part)
    @part = part.to_sym
  end

  def to_s # rubocop:disable Metrics/CyclomaticComplexity
    case @part
    when :part_1 then "Part I"
    when :part_2 then "Part II"
    when :part_3 then "Part III"
    when :part_4 then "Part IV"
    when :finance then "Finance"
    when :reports then "Management Reports"
    end
  end

  def bs_theme # rubocop:disable Metrics/CyclomaticComplexity
    case @part
    when :part_1 then :success
    when :part_2 then :info
    when :part_3 then :warning
    when :part_4 then :danger
    when :finance then :primary
    when :reports then :info
    end
  end

  def is?(part)
    @part == part
  end

  def root_path(user)
    return "/vessels" if user.read_only?

    case @part
    when :finance then "/finance/batches"
    when :reports then "/admin/reports"
    else
      "/tasks/my-tasks"
    end
  end

  def view_mode
    @part == :part_3 ? :basic : :extended
  end

  def printable_templates
    templates =
      case @part
      when :part_1, :part_4
        default_printable_templates + [:csr_form]
      else
        default_printable_templates
      end

    templates.sort
  end

  def registration_officer?
    @part.to_s.match(/^part_/)
  end

  def task_types # rubocop:disable Metrics/MethodLength
    default_tasks = Task.default_task_types
    excluded_tasks =
      case @part
      when :part_2
        [:issue_csr]
      when :part_3
        [:issue_csr, :mortgage, :provisional]
      when :part_4
        [:provisional, :re_registration, :mortgage]
      else
        []
      end
    default_tasks.select { |t| !excluded_tasks.include?(t[1]) }
  end

  private

  def default_printable_templates
    [
      :carving_and_marking,
      :registration_certificate,
      :cover_letter,
      :current_transcript,
      :historic_transcript,
      :provisional_certificate,
      :termination_notice,
    ]
  end
end
