require "rails_helper"

feature "categories things" do
  scenario "User creates a new category" do
    visit "/categories"
    new_category = "I created a category"
    expect(page.body).not_to include new_category
    click_link_or_button "New"
    fill_in "category[title]", with: new_category
    click_link_or_button "Create Category"
    expect(page.body).to include new_category
  end

  scenario "User deletes a category" do
    new_category = "I created a category"
    Category.create(title: new_category)

    visit "/categories"
    expect(page.body).to include new_category
    click_link_or_button "Title: #{new_category}"
    click_link_or_button "Delete"

    expect(page.body).not_to include new_category
  end
end
