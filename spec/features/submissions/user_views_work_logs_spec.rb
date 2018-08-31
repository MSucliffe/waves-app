require "rails_helper"

describe "User views work logs", js: true do
  before do
    part = submission.part
    task = create(:task, submission: submission)
    create(:work_log, part: part, loggable: task, description: :task_completed)

    login(create(:user), part)
    visit submission_task_path(submission, task)
    click_on("Work Logs")
  end

  context "part_2" do
    let(:submission) { create(:name_approval).submission }

    scenario "within the application" do
      within("#work_logs") do
        expect(page).to have_css(".description", text: "Task completed")
        expect(page).to have_link("Demo Service")
      end
    end

    scenario "within the part" do
      visit "/part_2/work_logs"

      within("#work_logs") do
        expect(page).to have_css(".description", text: "Task completed")
        expect(page).to have_link("Demo Service")

        expect(page)
          .to have_link(
            ApplicationType.new(submission.application_type).description,
            href: submission_path(submission))
      end
    end
  end

  context "part_3" do
    let(:submission) { create(:submission) }

    scenario "within the application" do
      within("#work_logs") do
        expect(page).to have_css(".description", text: "Task completed")
      end
    end
  end
end
