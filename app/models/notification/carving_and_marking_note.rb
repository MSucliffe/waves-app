class Notification::CarvingAndMarkingNote < Notification
  def email_template
    :carving_and_marking_note
  end

  def additional_params
    [actioned_by, email_attachments]
  end

  def email_subject
    "Carving & Marking Note: #{vessel_name}"
  end

  private

  def vessel_name
    notifiable.vessel_name if notifiable
  end

  def email_attachments
    Pdfs::Processor.run(attachments.to_sym, notifiable, :attachment).render
  end
end