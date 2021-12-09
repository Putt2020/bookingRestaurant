require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @rest1 = restaurants(:one)
    @rest2 = restaurants(:two)
    @rest3 = restaurants(:three)
    @rate1 = rates(:one)
    @rate2 = rates(:two)
    @rate3 = rates(:three)
    @rate4 = rates(:four)
    @rate5 = rates(:five)
  end

  test "see all restaurant" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    click_on "See restaurants"

    assert_text "#{@rest1.name}"
    assert_text "#{@rest2.name}"
    assert_text "#{@rest3.name}"
  end

  test "visit a restaurant" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    click_on "See restaurants"

    click_on "visit #{@rest1.name}"

    assert_text "#{@rest1.name} (rating 2.5)"
  end

  # test "visiting the index" do
  #   visit restaurants_url
  #   assert_selector "h1", text: "Restaurants"
  # end

  # test "creating a Restaurant" do
  #   visit restaurants_url
  #   click_on "New Restaurant"

  #   fill_in "Name", with: @restaurant.name
  #   click_on "Create Restaurant"

  #   assert_text "Restaurant was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Restaurant" do
  #   visit restaurants_url
  #   click_on "Edit", match: :first

  #   fill_in "Name", with: @restaurant.name
  #   click_on "Update Restaurant"

  #   assert_text "Restaurant was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Restaurant" do
  #   visit restaurants_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Restaurant was successfully destroyed"
  # end
end
