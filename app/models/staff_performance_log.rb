class StaffPerformanceLog < ApplicationRecord
  belongs_to :task, class_name: "Submission::Task"
  belongs_to :actioned_by, class_name: "User"

  enum activity: [:cancelled, :referred, :completed]
  enum service_level: ServiceLevel::SERVICE_LEVEL_TYPES.map(&:last)

  class << self
    def record(task, activity, actioned_by)
      create(
        task: task,
        activity: activity,
        service_level: task.service_level,
        target_date: task.target_date,
        actioned_by: actioned_by)
    end
  end
end
