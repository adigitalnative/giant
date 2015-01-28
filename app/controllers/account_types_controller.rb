class AccountTypesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :admin_only
  before_filter :find_account_type, only: [:edit, :update, :destroy]

  def new
    @account_type = AccountType.new
  end

  def create
    @account_type = AccountType.create(params[:account_type])
    if @account_type.valid?
      flash[:notice] = "Account type created"
      redirect_to admin_user_management_path
    else
      flash[:alert] = "Account type could not be created. #{@account_type.errors.messages}"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @account_type.update_attributes(params[:account_type])
      flash[:notice] = "Account type updated successfully"
      redirect_to admin_user_management_path
    else
      flash[:alert] = "Account type could not be updated"
      render 'edit'
    end
  end

  def destroy
    @account_type.delete
    flash[:notice] = "Account type deleted"
    redirect_to admin_user_management_path
  end

  private

  def find_account_type
    @account_type = AccountType.find(params[:id])
  end

end
