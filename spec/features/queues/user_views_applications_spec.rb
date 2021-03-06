require "rails_helper"

feature "User views applications", type: :feature, js: true do
  let!(:submission) do
    submission = create(:submission)
    create(:task, price: 2500, submission: submission)
    submission
  end

  before { login_to_part_3 }

  scenario "that are open" do
    visit open_submissions_path

    within("#submissions") do
      expect(page)
        .to have_css(".vessel-name", text: submission.vessel.name)
      expect(page).to have_content("New Registration")
      expect(page).to have_css("td.payment .fa-times.red")
      expect(page).to have_content("Online")
      expect(page).to have_content("1 task")
    end
  end

  scenario "that are completed" do
    visit closed_submissions_path

    expect(page).to have_css("h2", text: "There are no items in this queue")
  end
end
