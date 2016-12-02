require "rails_helper"

describe "User prints a current transcript", type: :feature, js: true do
  scenario "in general" do
    visit_registered_vessel

    click_on("Registrar Tools")

    pdf_window = window_opened_by do
      click_on("Print Current Transcript")
    end

    within_window(pdf_window) do
      expect(page).to have_text("%PDF")
    end
  end
end
