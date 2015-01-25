class Admin::UserManagementsController < ApplicationController

  before_filter :authenticate_user!

  def show
    @account_types = AccountType.all
  end

end
