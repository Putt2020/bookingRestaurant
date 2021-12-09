require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @rest1 = restaurants(:one)
    @rest2 = restaurants(:two)
    @rest3 = restaurants(:three)
    @comment = comments(:one)
  end

  test "Make and delete a comment" do
    visit main_path

    fill_in "Email", with: @user3.email
    fill_in "Password", with: "three"

    click_on "Login"

    click_on "See restaurants"

    click_on "visit #{@rest3.name}"

    click_on "comment"

    fill_in "Write your comment", with: "test comment"

    click_on "Comment"

    assert_text "Comment was successfully created."
    assert_text "test comment"
    assert_text "by : #{@user3.name}"

    page.accept_confirm do
      page.all('#del')[0].click
    end
    
    assert_text "Comment was successfully destroyed."
  end


  # test "visiting the index" do
  #   visit comments_url
  #   assert_selector "h1", text: "Comments"
  # end

  # test "creating a Comment" do
  #   visit comments_url
  #   click_on "New Comment"

  #   fill_in "Msg", with: @comment.msg
  #   fill_in "Restaurant", with: @comment.restaurant_id
  #   fill_in "User", with: @comment.user_id
  #   click_on "Create Comment"

  #   assert_text "Comment was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Comment" do
  #   visit comments_url
  #   click_on "Edit", match: :first

  #   fill_in "Msg", with: @comment.msg
  #   fill_in "Restaurant", with: @comment.restaurant_id
  #   fill_in "User", with: @comment.user_id
  #   click_on "Update Comment"

  #   assert_text "Comment was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Comment" do
  #   visit comments_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Comment was successfully destroyed"
  # end
end
