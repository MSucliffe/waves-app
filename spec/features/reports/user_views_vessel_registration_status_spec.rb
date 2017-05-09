require "rails_helper"

describe "User views vessel registration status", js: true do
  before do
    @vessel = create(:registered_vessel)
    @vessel.current_registration.update_attributes(
      registered_until: "20/01/2017")

    login_to_part_3
    find("a.reports_menu").click
    click_on("Vessel Registration Status")
  end

  scenario "in general" do
    expect(page).to have_css("h1", text: "Reports: Vessel Registration Status")
    expect(page).to have_css("th", text: "Name")
    expect(page).to have_css("th", text: "Official No")
    expect(page).to have_css("th", text: "Radio Call Sign")
    expect(page).to have_css("th", text: "Expiration Date")
    expect(page).to have_css("th", text: "Status")
  end

  scenario "filtering by date range" do
    date_range_result = @vessel.name
    expect(page).to have_text(date_range_result)

    find("#filter_date_start").set("21/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    expect(page).not_to have_text(date_range_result)

    find("#filter_date_start").set("19/01/2017")
    find("#filter_date_end").set("22/01/2017")
    click_on("Apply Filter")

    expect(page).to have_text(date_range_result)
  end
end
