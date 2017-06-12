require "rails_helper"

describe "User edits Managed By", js: :true do
  scenario "in general" do
    visit_name_approved_part_2_submission
    click_on("Owners & Shareholding")
    click_on("Add Managed By")

    within(".modal.fade.in") do
      expect_postcode_lookup
      fill_in("Name", with: "BOB BOLD")
      select("FRANCE", from: "Nationality")
      click_on("Save")
    end

    expect(page).to have_css(".managed_by-name", text: "BOB BOLD")
    expect(page).to have_css(".managed_by-nationality", text: "FRANCE")

    click_on("BOB BOLD")
    select("SPAIN", from: "Nationality")
    click_on("Save")

    expect(page).to have_css(".managed_by-nationality", text: "SPAIN")

    within("#managed_by") do
      click_on("Remove")
      expect(page).not_to have_css(".managed_by-name")
      expect(Submission.last.managed_bys).to be_empty
    end
  end
end