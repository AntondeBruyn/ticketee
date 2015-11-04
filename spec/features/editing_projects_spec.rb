require "rails_helper"

RSpec.feature "Editing Projects" do
  before do
    FactoryGirl.create(:project, name: "Sublime Text 3")

    visit "/"
    click_link "Sublime Text 3"
    click_link "Edit Project"
  end

  scenario "Updating a project" do
    fill_in "Name", with: "Sublime Text 3 beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated.")
  end
end
