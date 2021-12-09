require "application_system_test_case"

class FavoritesTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @rest1 = restaurants(:one)
    @rest2 = restaurants(:two)
    @rest3 = restaurants(:three)
    @favorite = favorites(:one)
  end

  test "have favorite" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    click_on "See favorites"

    assert_text "#{@rest1.name}"
    assert_text "#{@rest2.name}"
    assert_text "#{@rest3.name}"
  end

  test "does not have favorite" do
    visit main_path

    fill_in "Email", with: @user3.email
    fill_in "Password", with: "three"

    click_on "Login"

    click_on "See favorites"

    assert_text "No data available in table"
  end

  test "follow and unfollow a restaurant" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    click_on "See favorites"

    click_on "visit #{@rest1.name}"

    assert_text "#{@rest1.name} (rating 2.5)"

    click_on "Unfavorite"

    assert_text "You just unfavorite #{@rest1.name}"

    click_on "See favorites"

    assert_no_text "#{@rest1.name}"

    click_on "See restaurants"

    click_on "visit #{@rest1.name}"

    assert_text "#{@rest1.name} (rating 2.5)"

    click_on "Favorite"

    assert_text "You just favorite #{@rest1.name}"

    click_on "See favorites"

    assert_text "#{@rest1.name}"

    within(".az#{@rest1.name}") do
      page.accept_confirm do
        click_on "Remove"
      end
    end

    assert_no_text "#{@rest1.name}"
  end


  # test "visiting the index" do
  #   visit favorites_url
  #   assert_selector "h1", text: "Favorites"
  # end

  # test "creating a Favorite" do
  #   visit favorites_url
  #   click_on "New Favorite"

  #   fill_in "Restaurant", with: @favorite.restaurant_id
  #   fill_in "User", with: @favorite.user_id
  #   click_on "Create Favorite"

  #   assert_text "Favorite was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Favorite" do
  #   visit favorites_url
  #   click_on "Edit", match: :first

  #   fill_in "Restaurant", with: @favorite.restaurant_id
  #   fill_in "User", with: @favorite.user_id
  #   click_on "Update Favorite"

  #   assert_text "Favorite was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Favorite" do
  #   visit favorites_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Favorite was successfully destroyed"
  # end
end
