require 'spec_helper'

describe "A visitor" do
  it "requires the user to sign in" do
    visit admin_user_management_path
    within("#alert") { page.should have_content("need to sign in") }
  end
end

describe "A signed in user" do
  before do
    @signed_in_user = Factory(:user, email: "signed_in_user@mail.com")
    visit root_path
    fill_in "Email", with: @signed_in_user.email
    fill_in "Password", with: "password"
    click_link_or_button "Sign in"
  end

  it "can visit the admin user management page" do
    within("nav") do
      within("#admin") { click_link_or_button "User Management" }
    end
    current_path.should eq(admin_user_management_path)
  end

  describe "on the user management page" do
    it "can create account types" do
      visit admin_user_management_path
      within("#account_types") do
        click_link_or_button "Add Account Type"
      end
      fill_in "Name", with: "Account Name"
      click_link_or_button "Create Account type"
      page.should have_content ("Account type created")
    end
    describe "when there are account types" do
      before do
        @account_type_one = Factory(:account_type, name: "Account Type One")
        @account_type_two = Factory(:account_type, name: "Account Type Two")
        @account_type_three = Factory(:account_type, name: "Account Type Three")
        visit admin_user_management_path
      end

      it "can see a list of user types" do
        within("#account_types") do
          page.should have_selector("#account_type_#{@account_type_one.id}")
        end
      end

      describe "editing an account type" do
        before do
          within("#account_type_#{@account_type_one.id}") { click_link_or_button "Edit" }
          fill_in "Name", with: "New name"
          click_link_or_button "Update Account type"
        end

        it "succeeds" do
          within("#account_type_#{@account_type_one.id}") { page.should have_content("New name") }
        end

        it "has a good error message" do
          within("#notice") { page.should have_content "Account type updated successfully" }
        end

      end

      it "can delete a user type" do
        within("#account_type_#{@account_type_one.id}") { click_link_or_button "Delete" }
        within("#account_types") { page.should_not have_selector("#account_type_#{@account_type_one.id}")}
      end
    end
  end

end