require "rails_helper"

describe Registration do
  context "#delivery_name_and_address" do
    let(:registration) { create(:registration) }
    subject { registration.reload.delivery_name_and_address }

    context "with a submission" do
      let!(:submission) { create(:submission, registration: registration) }

      it "uses the submission's delivery address" do
        expect(subject[0]).to eq(submission.delivery_address.name)
      end
    end

    context "without a submission" do
      it "is an empty array" do
        expect(subject).to eq([])
      end
    end
  end

  context "#part" do
    let(:registration) { create(:registration, registry_info: registry_info) }

    context "when the registry_info is not defined (edge case)" do
      let(:registry_info) { nil }

      it "defaults to part_3" do
        expect(registration.part.to_sym).to eq(:part_3)
      end
    end

    context "when the registry_info#vessel_info is part_1" do
      let(:registry_info) { { vessel_info: { part: "part_1" } } }

      it { expect(registration.part).to eq(:part_1) }
    end
  end

  context "#prints_duplicate_certificate?" do
    let!(:registration) { create(:registration) }

    before do
      submission = double(:submission, task: task)

      allow(registration)
        .to receive(:submission)
        .and_return(submission)
    end

    subject { registration.prints_duplicate_certificate? }

    context "when the submission was for a duplicate_certificate" do
      let(:task) { :duplicate_certificate }

      it { expect(subject).to be_truthy }
    end

    context "when the submission was for a new_registration" do
      let(:task) { :new_registration }

      it { expect(subject).to be_falsey }
    end
  end
end
