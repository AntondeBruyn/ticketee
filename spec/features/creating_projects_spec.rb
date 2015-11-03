require "rails_helper"

RSpec.feature "Creating Projects" do
  scenario "A user can create a new project" do
    visit "/"

    click_link "New Project"

    fill_in "Name", with: "Sublime Text 3"
    fill_in "Description", with: "A text editor for everyone"
    click_button "Create Project"

    expect(page).to have_content("Project has been created.")
  end
end
    
