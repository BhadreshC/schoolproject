require "application_system_test_case"

class PrinciplesTest < ApplicationSystemTestCase
  setup do
    @principle = principles(:one)
  end

  test "visiting the index" do
    visit principles_url
    assert_selector "h1", text: "Principles"
  end

  test "creating a Principle" do
    visit principles_url
    click_on "New Principle"

    fill_in "Email", with: @principle.email
    fill_in "Password", with: 'secret'
    fill_in "Password confirmation", with: 'secret'
    fill_in "Username", with: @principle.username
    click_on "Create Principle"

    assert_text "Principle was successfully created"
    click_on "Back"
  end

  test "updating a Principle" do
    visit principles_url
    click_on "Edit", match: :first

    fill_in "Email", with: @principle.email
    fill_in "Password", with: 'secret'
    fill_in "Password confirmation", with: 'secret'
    fill_in "Username", with: @principle.username
    click_on "Update Principle"

    assert_text "Principle was successfully updated"
    click_on "Back"
  end

  test "destroying a Principle" do
    visit principles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Principle was successfully destroyed"
  end
end
