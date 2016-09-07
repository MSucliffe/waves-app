require "rails_helper"

describe Notification, type: :model do
  context "#create" do
    before { described_class.create }

    it "delivers the email" do
      expect(Delayed::Job.count).to eq(1)
    end
  end
end