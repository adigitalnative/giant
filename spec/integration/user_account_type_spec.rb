require 'spec_helper'

describe "A visitor to the site" do
  it "must sign in to access account type setup"
end

describe "A signed in non-admin user" do
  it "cannot view a list of registered users"
  it "cannot set account types"
end

describe "A signed in admin user" do
  before do
    @signed_in_admin = Factory(:user, email: "test_user_email@foomail.com")
    visit root_path
    fill_in "Email", with: @signed_in_admin.email
    fill_in "Password", with: "password"
    click_link_or_button "Sign in"
  end

  it "can view a list of registered users" do
    @user_one = Factory(:user, email: "user_one@mail.com")
    @user_two = Factory(:user, email: "user_two@mail.com")
    @user_three = Factory(:user, email: "user_three@mail.com")
    visit admin_user_management_path

    within("#users") { page.should have_selector("#user_#{@user_one.id}")}
    within("#users") { page.should have_selector("#user_#{@user_two.id}")}
    within("#users") { page.should have_selector("#user_#{@user_three.id}")}
  end

  it "can see the users' account types"
  it "can set a user's account type"
end