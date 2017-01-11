require "rails_helper"

describe Payment::FinancePayment do
  context "for a new application" do
    let!(:finance_payment) do
      described_class.create(
        payment_date: Date.today,
        part: :part_1,
        task: :unknown,
        vessel_reg_no: "",
        payment_type: :cash,
        payment_amount: "25",
        actioned_by: create(:user),
        applicant_name: "Bob",
        applicant_email: "bob@example.com",
        applicant_is_agent: true,
        application_ref_no: "ABC123",
        documents_received: "some files"
      )
    end

    let(:submission) { finance_payment.submission }

    it "is actioned_by a user" do
      expect(finance_payment.actioned_by).to be_present
    end

    it "creates the payment with the expected amount" do
      expect(finance_payment.payment.amount).to eq(2500)
    end

    it "sets the officer_intervention_required flag" do
      expect(submission.officer_intervention_required)
        .to be_truthy
    end

    it "sets the source" do
      expect(submission.source.to_sym).to eq(:manual_entry)
    end

    it "sets the state to unassigned so it is ready to be claimed" do
      expect(submission).to be_unassigned
    end

    it "sets the target date" do
      expect(submission.target_date).to be_present
    end

    it "sets the applicant_name" do
      expect(submission.applicant_name).to eq("Bob")
    end

    it "sets the applicant_email" do
      expect(submission.applicant_email)
        .to eq("bob@example.com")
    end

    it "sets the applicant_is_agent flag" do
      expect(finance_payment.submission.applicant_is_agent).to be_truthy
    end

    it "sets the linkable_ref_no in the changeset" do
      linkable_ref_no = submission.symbolized_changeset[:linkable_ref_no]
      expect(linkable_ref_no).to eq("ABC123")
    end

    it "sets the documents_received" do
      expect(submission.documents_received).to eq("some files")
    end
  end

  context "for a registered (when vessel_reg_no is valid)" do
    let(:registered_vessel) { create(:registered_vessel) }

    let!(:finance_payment) do
      described_class.create(
        payment_date: Date.today,
        part: registered_vessel.part,
        vessel_reg_no: registered_vessel.reg_no,
        payment_amount: "25",
        actioned_by: create(:user),
        task: :change_vessel
      )
    end

    it "creates an unassigned submission" do
      expect(finance_payment.submission.current_state).to eq(:unassigned)
    end

    it "sets the officer_intervention_required flag" do
      expect(finance_payment.submission.officer_intervention_required)
        .to be_truthy
    end
  end

  context "with invalid params" do
    let!(:finance_payment) do
      described_class.create(
        part: :part_1,
        payment_amount: "bob",
        task: nil,
        vessel_reg_no: "nonexistent"
      )
    end

    it { expect(finance_payment.errors).to include(:payment_date) }
    it { expect(finance_payment.errors).to include(:payment_amount) }
    it { expect(finance_payment.errors).to include(:task) }
    it { expect(finance_payment.errors).to include(:vessel_reg_no) }

    it "does not create the payment" do
      expect(finance_payment.payment).to be_nil
    end
  end
end
