require "rails_helper"

describe "User sets the correspondent", js: true do
  scenario "adding an owner and setting them as correspondent" do
    visit_claimed_task(
      submission: create(:submission, :part_2_vessel),
      service: create(:service, :update_registry_details))

    # remove the correspondent that was set by the factory
    Submission.last.update_attribute(:correspondent_id, nil)

    click_on("Owners & Shareholding")
    click_on("Add Individual Owner")

    fill_in("Name", with: "BOB BOLD")
    fill_in("Email", with: "bob@example.com")
    click_on("Save Individual Owner")

    within("#correspondent") do
      click_on("Add Correspondent")
      select("BOB BOLD", from: "Name")
      click_on("Save Correspondent")
    end

    expect(page).to have_css(".correspondent-name", text: "BOB BOLD")
  end
end
