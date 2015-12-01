require "rails_helper"

RSpec.feature "Creating Tickets" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: "Internet Explorer")
    assign_role!(user, :editor, project)

    visit "/"
    click_link "Internet Explorer"
    click_link "New Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
    within("#ticket #author") do
      expect(page).to have_content("Created by #{user.email}")
    end
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

  scenario "with multiple attachments" do
    fill_in "Title", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"

    attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
    attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
    attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")

    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")

    within("#ticket .assets") do
      expect(page).to have_content("speed.txt")
      expect(page).to have_content("spin.txt")
      expect(page).to have_content("gradient.txt")
    end
  end

  scenario "persisting file uploads across form displays" do
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    fill_in "Title", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    click_button "Create Ticket"
    save_and_open_page

    within("#ticket .assets") do
      expect(page).to have_content("speed.txt")
    end
  end
end
