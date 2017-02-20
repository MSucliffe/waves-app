require "rails_helper"

describe Declaration::Group do
  context ".create" do
    let!(:submission) { create(:unassigned_submission) }
    let!(:declaration) { submission.declarations.first }

    subject do
      described_class.create(
        submission: submission, default_group_member: declaration.id)
    end

    it "creates a Declaration::GroupMember for the default_group_member" do
      expect(subject.declaration_group_members.first.declaration)
        .to eq(declaration)
    end
  end
end