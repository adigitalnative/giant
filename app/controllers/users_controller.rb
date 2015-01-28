class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :admin_only
  before_filter :find_user_to_edit, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update_attributes(account_type_ids: params[:user][:account_type_ids])
      flash[:notice] = "User updated"
      redirect_to admin_user_management_path
    else
      flash[:alert] = "User could not be updated"
      render 'edit'
    end
  end

  private

  def find_user_to_edit
    @user = User.find(params[:id])
  end

end
