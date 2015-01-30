class Hoard::ItemsController < ApplicationController

  before_filter :authenticate_user!

  def show
    current_user_item_ids = current_user.items.map { |item| item.id }
    if current_user_item_ids.include?(params[:format].to_i)
      @item = Item.find(params[:format].to_i)
    else
      redirect_to hoard_path
      flash[:alert] = "You are not permitted to view someone else's hoard!"
    end
  end
end
