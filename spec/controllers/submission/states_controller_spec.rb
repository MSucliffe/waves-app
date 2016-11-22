require "rails_helper"

describe Submission::StatesController, type: :controller do
  before do
    sign_in claimant
  end

  let!(:claimant) { create(:user) }

  context "#claim" do
    before do
      post :claim,
           params: {
             submission_id: create(:unassigned_submission).id }, xhr: true
    end

    it "assigns the claimant" do
      expect(assigns[:submission].claimant).to eq(claimant)
    end

    it "renders the claim_button js" do
      expect(response).to render_template("tasks/actions/claim_button")
    end

    context "#unclaim" do
      before do
        post :unclaim,
             params: { submission_id: assigns[:submission].id }, xhr: true
      end

      it "unassigns the claimant" do
        expect(assigns[:submission].claimant).to be_nil
      end

      it "renders the claim_button js" do
        expect(response).to render_template("tasks/actions/claim_button")
      end
    end
  end

  context "#claim_referral" do
    before do
      post :claim_referral,
           params: { submission_id: create(:referred_submission).id }
    end

    it "assigns the claimant" do
      expect(assigns[:submission].claimant).to eq(claimant)
    end

    it "sets the status to assigned" do
      expect(assigns[:submission]).to be_assigned
    end
  end

  context "#approve" do
    let(:submission) { create(:assigned_submission) }

    context "succesfully" do
      before { post :approve, params: { submission_id: submission.id } }

      it "moves the submission to :printing" do
        expect(assigns[:submission]).to be_printing
      end

      it "renders the aproved page" do
        expect(response).to render_template("approved")
      end

      it "creates a notification for the applicant" do
        expect(Notification::ApplicationApproval.count).to eq(1)

        expect(Notification::ApplicationApproval.first.recipient_name)
          .to eq(submission.applicant_name)

        expect(Notification::ApplicationApproval.first.recipient_email)
          .to eq(submission.applicant_email)
      end

      it "sets the notification#actioned_by" do
        expect(Notification::ApplicationApproval.first.actioned_by)
          .to eq(claimant)
      end
    end

    context "when printing is not required" do
      before do
        allow_any_instance_of(Submission)
          .to receive(:printing_required?)
          .and_return(false)

        post :approve, params: { submission_id: submission.id }
      end

      it "moves the submission to :completed" do
        expect(assigns[:submission]).to be_completed
      end

      it "renders the aproved page" do
        expect(response).to render_template("approved")
      end

      it "creates a notification for the applicant" do
        expect(Notification::ApplicationApproval.count).to eq(1)
      end

      it "sets the notification#actioned_by" do
        expect(Notification::ApplicationApproval.first.actioned_by)
          .to eq(claimant)
      end
    end

    context "unsuccessfully" do
      before do
        allow_any_instance_of(Submission)
          .to receive(:move_to_print_queue!).and_return(false)
        post :approve, params: { submission_id: submission.id }
      end

      it "is still :assigned" do
        expect(assigns[:submission]).to be_assigned
      end

      it "renders the errors page" do
        expect(response).to render_template("errors")
      end
    end
  end
end
