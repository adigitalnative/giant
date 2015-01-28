require 'spec_helper'

describe "A visitor to the site" do
  it "must sign in to access account type setup" do
    visit admin_user_management_path
    page.should have_content("need to sign in")
  end
end

describe "A signed in non-admin user" do
  before do
    @signed_in_user = Factory(:user, email: "test_user@foomail.com")
    visit root_path
    fill_in "Email", with: @signed_in_user.email
    fill_in "Password", with: "password"
    click_link_or_button "Sign in"
  end

  it "cannot view a list of registered users" do
    visit admin_user_management_path
    page.should have_content("Sorry, only admin")
  end

  it "cannot set account types" do
    visit edit_user_path(@signed_in_user.id)
    page.should have_content("Sorry, only admin")
  end
end

describe "A signed in admin user" do # These will be admin actions.
  before do
    @signed_in_admin = Factory(:user, email: "test_adminuser_email@foomail.com")
    admin_account_type = Factory(:account_type, name: "Admin")
    @signed_in_admin.account_types << admin_account_type
    visit root_path
    fill_in "Email", with: @signed_in_admin.email
    fill_in "Password", with: "password"
    click_link_or_button "Sign in"

    @user_one = Factory(:user, email: "user_one@mail.com")
    @user_two = Factory(:user, email: "user_two@mail.com")
    @user_three = Factory(:user, email: "user_three@mail.com")
  end

  it "can view a list of registered users" do
    visit admin_user_management_path

    within("#users") { page.should have_selector("#user_#{@user_one.id}")}
    within("#users") { page.should have_selector("#user_#{@user_two.id}")}
    within("#users") { page.should have_selector("#user_#{@user_three.id}")}
  end

  it "can see the users' account types" do
    admin_account_type = Factory(:account_type, name: "Admin")
    @user_one.account_types << admin_account_type
    visit admin_user_management_path

    within("#user_#{@user_one.id}") { page.should have_content("Admin") }
  end

  it "accesses the right page when edit is clicked" do
    visit admin_user_management_path
    account_type = Factory(:account_type, name: "New Account Type")
    within("#user_#{@user_two.id}") { click_link_or_button "Edit" }

    current_path.should eq(edit_user_path(@user_two.id))
  end

  it "can set a user's account type" do
    visit admin_user_management_path
    account_type = Factory(:account_type, name: "New Account Type")
    within("#user_#{@user_two.id}") { click_link_or_button "Edit" }

    select account_type.name, from: "Account types"
    click_link_or_button "Update User"

    page.should have_content("User updated")
    within("#user_#{@user_two.id}") { page.should have_content(account_type.name) }
  end
end