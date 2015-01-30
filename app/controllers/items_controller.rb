class ItemsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :find_item, only: [:edit, :update, :destroy]

  def index
    
  end

  def new
    @item = @user.items.new
  end

  def create
    @item = @user.items.build(params[:item])
    if @item.save
      flash[:notice] = "Item added to your hoard"
      redirect_to hoard_path
    else
      puts @item.item_types.inspect
      flash[:alert] = "Item not created"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @item.update_attributes(params[:item])
      flash[:notice] = "Item updated"
      redirect_to hoard_path
    else
      flash[:alert] = "Item not updated"
      render 'edit'
    end
  end

  def destroy
    @item.delete
    flash[:notice] = "Item deleted"
    redirect_to hoard_path
  end

  private

  def find_user
    @user = current_user
  end

  def find_item
    @item = @user.items.find(params[:id])
  end

end
