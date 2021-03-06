class Pdfs::RenewalReminderLetter
  def initialize(registrations, mode = :printable)
    @registrations = Array(registrations)
    @template = :current
    @mode = mode
    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @registrations.each do |registration|
      @pdf = renewal_reminder_letter_writer(registration)
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    if @registrations.length == 1
      single_transcript_filename
    else
      "renewal-reminders.pdf"
    end
  end

  protected

  def single_transcript_filename
    registration = @registrations.first
    title = registration.vessel_name.parameterize
    "#{title}-renewal-reminder.pdf"
  end
end
