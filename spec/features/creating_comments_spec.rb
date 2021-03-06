require "rails_helper"

RSpec.feature "Users can comment on tickets" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket,
                                     project: project,
                                     author: user) }

  before do
    login_as(user)
    assign_role!(user, :manager, project)
    FactoryGirl.create(:state, name: "Open")

    visit "/"
    click_link project.name
  end

  scenario "with valid attributes" do
    click_link ticket.title
    fill_in "Text", with: "Added a comment!"
    click_button "Create Comment"

    expect(page).to have_content("Comment has been created.")
    within("#comments") do
      expect(page).to have_content("Added a comment!")
    end
  end

  scenario "with invalid attributes" do
    click_link ticket.title
    click_button "Create Comment"

    expect(page).to have_content("Comment has not been created.")
  end

  scenario "when changing a ticket's state" do
    click_link ticket.title
    fill_in "Text", with: "This is a real issue"

    click_button "Create Comment"

    expect(page).to have_content("Comment has been created.")

    within("#comments") do
      expect(page).to have_content("state changed to Open")
    end
  end

  scenario "cannot change the state without permission" do
    assign_role!(user, :editor, project)

    click_link ticket.title
    expect(page).not_to have_select "State"
  end

  scenario "when adding a new tag to a ticket" do
    click_link ticket.title
    expect(page).not_to have_content("bug")

    fill_in "Text", with: "Adding the bug tag"
    fill_in "Tags", with: "bug"
    click_button "Create Comment"

    expect(page).to have_content("Comment has been created.")
    within("#ticket #tags") do
      expect(page).to have_content("bug")
    end
  end
end
