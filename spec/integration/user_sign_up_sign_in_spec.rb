require 'spec_helper'

describe "A visitor to the site" do
  describe "signing up" do
    describe "with good inputs" do
      before do
        visit root_path
        click_link_or_button "Sign up"
        fill_in "Email", with: "test_sign_up@foomail.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        fill_in "First name", with: "Jane"
        fill_in "Last name", with: "Doe"
      end

      it "succeeds" do
        click_link_or_button "Sign up"
        within("#notice") { page.should have_content "Welcome" }
      end

      it "can have a phone number" do
        fill_in "Phone", with: "2024896128"
        click_link_or_button "Sign up"
        within("#notice") { page.should have_content "Welcome" }
      end
    end
  end

  describe "signing in" do
    before do
      @signed_in_user = Factory(:user, email:"test_user@testmail.com")
      visit root_path
      fill_in "Email", with: @signed_in_user.email
      fill_in "Password", with: @signed_in_user.password
      click_link_or_button "Sign in"
    end

    it "succeeds" do
      page.should have_content("Signed in")
    end
  end

  describe "signing out" do
    before do
      @signed_in_user = Factory(:user, email:"test_user@testmail.com")
      visit root_path
      fill_in "Email", with: @signed_in_user.email
      fill_in "Password", with: @signed_in_user.password
      click_link_or_button "Sign in"

      within("nav") { click_link_or_button "Sign out" }
    end

    it "succeeds" do
      within("#alert") {page.should have_content("You need to sign in")}
    end
  end
end

describe "A signed in user" do
  it "has a link to edit their profile info" do
    @signed_in_user = Factory(:user, email:"test_user@testmail.com")
    visit root_path
    fill_in "Email", with: @signed_in_user.email
    fill_in "Password", with: @signed_in_user.password
    click_link_or_button "Sign in"

    within("nav") { click_link_or_button "Edit Account"}

    current_path.should eq(edit_user_registration_path(@signed_in_user.id))
  end
end