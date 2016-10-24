require "rails_helper"

describe Payment::FinancePayment do
  context "with valid params" do
    let!(:finance_payment) do
      described_class.create(
        part: :part_1,
        task: :unknown,
        payment_type: :cash,
        payment_amount: "25",
        actioned_by: create(:user)
      )
    end

    it "is actioned_by a user" do
      expect(finance_payment.actioned_by).to be_present
    end

    it "creates the payment with the expected amount" do
      expect(finance_payment.payment.amount).to eq(2500)
    end

    it "has a submission ref_no" do
      expect(finance_payment.submission_ref_no).to be_present
    end
  end

  context "with invalid params" do
    let!(:finance_payment) do
      described_class.create(
        part: nil,
        payment_amount: "bob",
        task: nil
      )
    end

    it { expect(finance_payment.errors).to include(:part) }
    it { expect(finance_payment.errors).to include(:payment_amount) }
    it { expect(finance_payment.errors).to include(:task) }

    it "does not create the payment" do
      expect(finance_payment.payment).to be_nil
    end
  end
end