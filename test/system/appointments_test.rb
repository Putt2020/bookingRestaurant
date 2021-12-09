require "application_system_test_case"

class AppointmentsTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @rest1 = restaurants(:one)
    @rest2 = restaurants(:two)
    @rest3 = restaurants(:three)
    # @appointment = appointments(:one)
  end

  #Please be aware of the time you test this one, this one use UTC time zone 
  #if you book the time that already passed, it will throw error
  test "Make and delete an anppointment" do
    visit main_path

    fill_in "Email", with: @user3.email
    fill_in "Password", with: "three"

    click_on "Login"

    click_on "See restaurant"

    click_on "visit #{@rest1.name}"

    click_on "appointment"

    select '1', from: "appointment_table_number"
    select '20:00', from: "appointment_start_time"
    fill_in "People amount", with: 2

    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "Appointment was successfully created."

    page.accept_confirm do
      find('img#del2').click
    end
    
    assert_text "Appointment was successfully destroyed."
  end

  test "missing input" do
    visit main_path

    fill_in "Email", with: @user3.email
    fill_in "Password", with: "three"

    click_on "Login"

    click_on "See restaurants"

    click_on "visit #{@rest1.name}"

    click_on "appointment"

    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "Table number is invalid"
    assert_text "Start time is invalid or in the past"
    
  end

  test "invalid input" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    click_on "See restaurants"

    click_on "visit #{@rest1.name}"

    click_on "appointment"

    select '1', from: "appointment_table_number"
    select '20:00', from: "appointment_start_time"
    fill_in "People amount", with: 0

    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "People amount can't be 0 or less than"

    select '1', from: "appointment_table_number"
    select '20:00', from: "appointment_start_time"
    fill_in "People amount", with: 69

    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "People amount is invalid"
  end

  test "appointment was booked case" do
    visit main_path

    fill_in "Email", with: @user1.email
    fill_in "Password", with: "one"

    click_on "Login"

    click_on "See restaurant"

    click_on "visit #{@rest1.name}"

    click_on "appointment"

    select '1', from: "appointment_table_number"
    select '20:00', from: "appointment_start_time"
    fill_in "People amount", with: 2

    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "Appointment was successfully created."

    click_on "Logout"

    fill_in "Email", with: @user2.email
    fill_in "Password", with: "two"

    click_on "Login"

    click_on "See restaurant"

    click_on "visit #{@rest1.name}"

    click_on "appointment"

    select '1', from: "appointment_table_number"
    select '20:00', from: "appointment_start_time"
    fill_in "People amount", with: 2

    page.accept_confirm do
      click_on "Confirm"
    end

    assert_text "Start time is canceled, this table is occupied"

    click_on "Home"

    assert_text "There is no appointment."
  end

  # test "visiting the index" do
  #   visit appointments_url
  #   assert_selector "h1", text: "Appointments"
  # end

  # test "creating a Appointment" do
  #   visit appointments_url
  #   click_on "New Appointment"

  #   fill_in "People amount", with: @appointment.people_amount
  #   fill_in "Start time", with: @appointment.start_time
  #   fill_in "Table", with: @appointment.table_id
  #   fill_in "User", with: @appointment.user_id
  #   click_on "Create Appointment"

  #   assert_text "Appointment was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Appointment" do
  #   visit appointments_url
  #   click_on "Edit", match: :first

  #   fill_in "People amount", with: @appointment.people_amount
  #   fill_in "Start time", with: @appointment.start_time
  #   fill_in "Table", with: @appointment.table_id
  #   fill_in "User", with: @appointment.user_id
  #   click_on "Update Appointment"

  #   assert_text "Appointment was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Appointment" do
  #   visit appointments_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Appointment was successfully destroyed"
  # end
end
