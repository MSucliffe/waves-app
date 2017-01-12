require "rails_helper"

describe FinanceBatch do
  let!(:batch) { create(:finance_batch) }

  context ".toggle_state!" do
    it "is open" do
      expect(batch).to be_open
    end

    context "ending a batch" do
      before { batch.toggle_state! }
      it { expect(batch).to be_closed }

      context "reopening a closed batch" do
        before { batch.toggle_state! }
        it { expect(batch).to be_open }
      end
    end
  end

  context ".lock!" do
    before { batch.lock! }

    it "locks the batch" do
      expect(batch).to be_locked
    end

    it "locks the finance_payments" do
      expect(batch.finance_payments.first).to be_locked
    end

    it "is neither open nor closed" do
      expect(batch).not_to be_open
      expect(batch).not_to be_closed
    end
  end

  context ".total_amount" do
    before do
      expect(batch)
        .to receive(:finance_payments).and_return(
          [
            create(:finance_payment, payment_amount: 2020),
            create(:finance_payment, payment_amount: 1111)]
        )
    end

    it { expect(batch.total_amount).to eq(3131) }
  end
end
