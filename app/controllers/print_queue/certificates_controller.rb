class PrintQueue::CertificatesController < InternalPagesController
  before_action :load_submissions

  def index
    respond_to do |format|
      format.html
      format.pdf do
        load_registrations
        pdf = Pdfs::Certificate.new(@registrations)
        mark_submissions_printed

        render_pdf(pdf, pdf.filename)
      end
    end
  end

  protected

  def load_submissions
    @submissions = Submission
                   .includes([registration: [vessel: [:owners]]]).printing
  end

  def load_registrations
    @registrations = @submissions.map(&:registration)
  end

  def mark_submissions_printed
    @submissions.map do |submission|
      submission.update_print_job!(:registration_certificate)
    end
  end
end