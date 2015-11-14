require "rails_helper"

RSpec.feature "Creating Tickets" do
  before do
    FactoryGirl.create(:project, name: "Internet Explorer")

  visit "/"
    click_link "Internet Explorer"
    click_link "New Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
  end

  scenario "with missing fields" do
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "with an invalid description" do
    fill_in "Title", with: "non-standards compliance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end
