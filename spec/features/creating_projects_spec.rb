require "rails_helper"

RSpec.feature "Creating Projects" do
 before do
   visit "/"

   click_link "New Project"
 end

 scenario "A user can create a new project" do
   fill_in "Name", with: "Sublime Text 3"
   fill_in "Description", with: "A text editor for everyone"
   click_button "Create Project"

   expect(page).to have_content("Project has been created.")

   project = Project.find_by(name: "Sublime Text 3")
   expect(page.current_url).to eql(project_url(project))

save_and_open_page
   title = "Sublime Text 3 - Projects - Ticketee"
   expect(page).to have_title(title)
 end

 scenario "A user cannot create a project without a name" do
   click_button "Create Project"

   expect(page).to have_content("Project has not been created.")
   expect(page).to have_content("Name can't be blank")
 end
end
