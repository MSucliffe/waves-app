require "rails_helper"

feature "User refers a submission", type: :feature, js: true do
  before do
    visit_completeable_submission
  end

  scenario "and restores it" do
    within('#actions') { click_on "Refer Application" }

    fill_in "Due By", with: "12/12/2020"
    select "Unknown vessel type", from: "Reason for Referral"
    fill_in "Additional Information", with: "Some stuff"

    within('#refer-application') { click_on "Refer Application" }

    click_on "Referred Applications"
    expect(page).to have_css('.referred-until', text: "12/12/2020")

    click_on("Celebrator Doppelbock")
    expect(page).to have_css('#prompt', /Application Referred by.*: Unsuitable name. Next action .*/)

    click_on "Cancel Referral"

    click_on "My Tasks"
    expect(page).to have_css('.vessel-name', text: "Celebrator Doppelbock")
  end
end
