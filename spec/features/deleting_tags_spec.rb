require "rails_helper"

RSpec.feature "Deleting tags" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) do
    FactoryGirl.create(:ticket, project: project,
            tag_names: "This tag must die", author: user)
  end

  before do
    login_as(user)
    assign_role!(user, :manager, project)
    visit "/"
    click_link project.name
    click_link ticket.title
  end

  scenario "successfully", js: true do
    within tag("This tag must die") do
      click_link "remove"
    end

    expect(page).to_not have_content("This tag must die")
  end
end
