require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @rest1 = restaurants(:one)
  end

  test "register success" do
    visit main_url
    click_on "register"

    fill_in "Email", with: "test"
    fill_in "Name", with: "test"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"

    click_on "Create Account"

    assert_text "User was successfully created."
  end 

  test "fail register" do
    visit main_path
    click_on "register"

    fill_in "Email", with: "onea"
    fill_in "Name", with: ""
    fill_in "Password", with: "abc"
    fill_in "Password confirmation", with: "a"

    click_on "Create Account"

    assert_text "Email has already been taken"
    assert_text "Name can't be blank"
    assert_text "Password confirmation doesn't match Password"
  end 

  test "login success" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    assert_text "Your name : #{@user1.name}"
  end

  test "login fail" do
    visit main_path

    fill_in "Email", with: "failEmail"
    fill_in "Password", with: "failPassword"

    click_on "Login"

    assert_text "Either email or password is incorrect :)"
  end

  test "please login first" do
    visit home_path
    assert_text "you did not login"

    visit favorite_path
    assert_text "you did not login"

    visit editProfile_path
    assert_text "you did not login"

    visit restaurantList_path
    assert_text "you did not login"

    visit "/restaurant/#{@rest1.name}"
    assert_text "you did not login"

    visit "/rate/#{@rest1.name}"
    assert_text "you did not login"

    visit "/comment/#{@rest1.name}"
    assert_text "you did not login"

    visit "/appointment/#{@rest1.name}"
    assert_text "you did not login"
  end

  test "edit profile success" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"
    click_on "edit profile"

    fill_in "Name", with: "abcde"

    click_on "Edit Account"

    assert_text "Your name : abcde"
  end

  test "edit profile fail" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"
    click_on "edit profile"

    fill_in "Name", with: ""

    click_on "Edit Account"

    assert_text "Name can't be blank"
  end


  # test "visiting the index" do
  #   visit users_url
  #   assert_selector "h1", text: "Users"
  # end

  # test "creating a User" do
  #   visit users_url
  #   click_on "New User"

  #   fill_in "Email", with: @user.email
  #   fill_in "Name", with: @user.name
  #   fill_in "Password digest", with: @user.password_digest
  #   click_on "Create User"

  #   assert_text "User was successfully created"
  #   click_on "Back"
  # end

  # test "updating a User" do
  #   visit users_url
  #   click_on "Edit", match: :first

  #   fill_in "Email", with: @user.email
  #   fill_in "Name", with: @user.name
  #   fill_in "Password digest", with: @user.password_digest
  #   click_on "Update User"

  #   assert_text "User was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a User" do
  #   visit users_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "User was successfully destroyed"
  # end
end
