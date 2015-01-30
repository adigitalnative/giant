require 'spec_helper'

describe "A visitor" do
  it "must sign in to view the warehouse" do
    visit warehouse_path
    page.should have_content("need to sign in")
  end

  it "must sign in to view a warehouse item" do
    visit warehouse_item_path(Factory(:item).id)
    page.should have_content("need to sign in")
  end
end

describe "A signed in user" do
  before do
    @signed_in_user = Factory(:user, email: "signed_in@mail.com")
    visit warehouse_path
    fill_in "Email", with: @signed_in_user.email
    fill_in "Password", with: "password"
    click_link_or_button("Sign in")
  end

  describe "when no other users have items viewing your own items" do
    it "lists your items" do
      item_one = Factory(:item, user_id: @signed_in_user.id)
      visit warehouse_path
      within("#items") { page.should have_selector("#item_#{item_one.id}") }
    end

    it "can view your items' details" do
      item_one = Factory(:item, user_id: @signed_in_user.id)
      visit warehouse_path
      within("#item_#{item_one.id}") { click_link_or_button(item_one.name) }
      current_path.should eq(warehouse_item_path(item_one.id))
    end

    it "can edit your item" do
      item_one = Factory(:item, user_id: @signed_in_user.id)
      visit warehouse_item_path(item_one.id)
      within("#item") { click_link_or_button "Edit" }
      current_path.should eq(edit_user_item_path(@signed_in_user.id, item_one.id))
    end
  end

  describe "when other users have items" do
    describe "viewing other users' items" do
      before do
        @other_user_item_one = Factory(:item, user_id: Factory(:user).id)
        visit warehouse_path
      end

      it "displays other users' items to you" do
        within("#items") { page.should have_selector("#item_#{ @other_user_item_one.id }") }
      end

      it "succeeds in accessing the show for an item" do
        within("#item_#{ @other_user_item_one.id }") { click_link_or_button @other_user_item_one.name }
        current_path.should eq(warehouse_item_path(@other_user_item_one.id))
      end

      it "does not have an edit link" do
        visit warehouse_item_path(@other_user_item_one.id)
        within("#item") { page.should_not have_content("Edit") }
      end

      describe "visiting the edit path for another user's item" do
        it "redirects to the warehouse path"
        it "gives a nice error message"
      end
    end
    
  end
end