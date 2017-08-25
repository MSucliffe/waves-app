require "rails_helper"

feature "User creates a document entry", type: :feature do
  scenario "in general" do
    login_to_part_1
    click_on("Document Entry")
    within(".modal#start-new-application") { click_on("New Registration") }

    select("Pleasure", from: "Registration Type")
    fill_in("Vessel Name", with: "MY BOAT")

    click_on("Save Application")
    visit tasks_unclaimed_path

    expect(page)
      .to have_css("#submissions .registration_type", text: "Pleasure")
  end
end