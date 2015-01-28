class Admin::UserManagementsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :admin_only

  def show
    @account_types = AccountType.all
    @users = User.all
  end

end
