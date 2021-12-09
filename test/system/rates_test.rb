require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
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

  test "update a rate" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    click_on "See restaurants"

    click_on "visit #{@rest1.name}"

    assert_text "#{@rest1.name} (rating 2.5)"

    click_on "rate"

    select '4', from: "rate_rate_score"

    page.accept_confirm do
      click_on "Rate"
    end

    assert_text "#{@rest1.name} (rating 3.0)"
  end

  test "create a rate" do
    visit main_path

    fill_in "Email", with: @user3.email
    fill_in "Password", with: "three"

    click_on "Login"

    click_on "See restaurants"

    click_on "visit #{@rest3.name}"

    assert_text "#{@rest3.name} (rating 0)"

    click_on "rate"
    
    select '4', from: "rate_rate_score"

    page.accept_confirm do
      click_on "Rate"
    end

    assert_text "#{@rest3.name} (rating 4.0)"
  end

  # test "visiting the index" do
  #   visit rates_url
  #   assert_selector "h1", text: "Rates"
  # end

  # test "creating a Rate" do
  #   visit rates_url
  #   click_on "New Rate"

  #   fill_in "Rate score", with: @rate.rate_score
  #   fill_in "Restaurant", with: @rate.restaurant_id
  #   fill_in "User", with: @rate.user_id
  #   click_on "Create Rate"

  #   assert_text "Rate was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Rate" do
  #   visit rates_url
  #   click_on "Edit", match: :first

  #   fill_in "Rate score", with: @rate.rate_score
  #   fill_in "Restaurant", with: @rate.restaurant_id
  #   fill_in "User", with: @rate.user_id
  #   click_on "Update Rate"

  #   assert_text "Rate was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Rate" do
  #   visit rates_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Rate was successfully destroyed"
  # end
end
