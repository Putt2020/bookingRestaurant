require "application_system_test_case"

class LikesTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @rest1 = restaurants(:one)
    @rest2 = restaurants(:two)
    @rest3 = restaurants(:three)
    @like = likes(:one)
  end

  test "like dislike a comment" do
    visit main_path

    fill_in "Email", with: @user2.email
    fill_in "Password", with: "two"

    click_on "Login"

    click_on "See restaurants"

    click_on "visit #{@rest2.name}"

    assert_text "total like: 0"
    click_on "Like", match: :first
    assert_text "total like: 1"
    click_on "Dislike", match: :first
    assert_text "total like: 0"
    click_on "Undislike"

    assert_text "total like: 2"
    page.all('.Like')[1].click
    # click_on "Like", match: :second
    assert_text "total like: 3"
    page.all('.Dislike')[1].click
    # click_on "Dislike", match: :second
    assert_text "total like: 1"
    click_on "Undislike"
    assert_text "total like: 2"
  end

  # test "visiting the index" do
  #   visit likes_url
  #   assert_selector "h1", text: "Likes"
  # end

  # test "creating a Like" do
  #   visit likes_url
  #   click_on "New Like"

  #   fill_in "Comment", with: @like.comment_id
  #   check "Like tag" if @like.like_tag
  #   fill_in "User", with: @like.user_id
  #   click_on "Create Like"

  #   assert_text "Like was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Like" do
  #   visit likes_url
  #   click_on "Edit", match: :first

  #   fill_in "Comment", with: @like.comment_id
  #   check "Like tag" if @like.like_tag
  #   fill_in "User", with: @like.user_id
  #   click_on "Update Like"

  #   assert_text "Like was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Like" do
  #   visit likes_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Like was successfully destroyed"
  # end
end
