require "rails_helper"

describe "User converts finance payment", type: :feature, js: true do
  before do
    create(
      :submitted_finance_payment,
      part: :part_3,
      task: :new_registration,
      vessel_name: "MY BOAT", applicant_name: "BOB")

    login_to_part_3
    click_on("Fee Entries")
  end

  scenario "when they have claimed it they can 'convert' it" do
    click_on("Claim")
    click_on("My Tasks")
    click_on("MY BOAT")

    expect(page).to have_css("h1", text: "New Registration")

    within("#actions") do
      click_on("Convert to Application")
    end

    expect(page).to have_css(".alert", text: "successfully converted")
  end

  scenario "when they have not claimed it they can't 'convert' it" do
    click_on("MY BOAT")

    expect(page).to have_css("h1", text: "New Registration")
    expect(page).not_to have_css("#actions")
  end
end
