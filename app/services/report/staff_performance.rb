class Report::StaffPerformance < Report
  def title
    "Staff Performance"
  end

  def sub_report
    :staff_performance_by_task
  end

  def filter_fields
    [:filter_part, :filter_date_range]
  end

  def headings
    [
      :task_type, :total_transactions,
      :within_service_standard, :service_standard_missed
    ]
  end

  def date_range_label
    "Application Received"
  end

  def results
    services.map do |service|
      staff_performance_logs = staff_performance_filters(service)
      Result.new(
        [service.to_s,
         staff_performance_logs.count,
         staff_performance_logs.within_standard.count,
         RenderAsRed.new(staff_performance_logs.standard_missed.count)],
        service: service.id)
    end
  end

  def services
    Service
      .in_part(@part)
      .order(:name)
      .includes(:staff_performance_logs)
      .all
  end

  def filter_by_completed_at(q)
    if @date_start.present?
      q = q.where("staff_performance_logs.created_at >= ?", @date_start)
    end
    if @date_end.present?
      q = q.where("staff_performance_logs.created_at <= ?", @date_end)
    end
    q
  end

  def staff_performance_filters(service)
    filter_by_completed_at(service.staff_performance_logs.in_part(@part))
  end
end
