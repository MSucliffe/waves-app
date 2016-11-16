require "rails_helper"

describe "Finance enters a payment", type: :feature do
  before do
    login_to_finance
  end

  scenario "in its simplest form" do
    expect(page).to have_css(".active-register", text: "Active: Finance")
    expect(page).to have_css("h1", text: "Finance: Record Payment")

    fill_in("Payment Date", with: "12/12/2012")
    select("Part III", from: "Part of Register")
    select("New Registration", from: "Task Type")
    fill_in("Official Number", with: "OFFICIAL_NO")
    fill_in("Vessel Name", with: "MY BOAT")

    select("Premium", from: "Service Level")
    select("Cheque", from: "Payment Type")
    fill_in("Fee Amount", with: "25")
    fill_in("Fee Receipt Number", with: "123")

    fill_in("Applicant Name", with: "BOB")
    fill_in("Applicant Email", with: "bob@example.com")
    fill_in("Documents Received", with: "bits and bobs")

    click_on("Save Application")

    expect(page).to have_css(".alert", text: "Payment successfully recorded")

    within("#finance_payment") do
      expect(page).to have_text("12/12/2012")
      expect(page).to have_text("Part III")
      expect(page).to have_text("New Registration")
      expect(page).to have_text("OFFICIAL_NO")
      expect(page).to have_text("MY BOAT")
      expect(page).to have_text("Premium")
      expect(page).to have_text("Cheque")
      expect(page).to have_text("25.00")
      expect(page).to have_text("BOB")
      expect(page).to have_text("bob@example.com")
      expect(page).to have_text("bits and bobs")
    end
  end
end
