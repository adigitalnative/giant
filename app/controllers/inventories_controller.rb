class InventoriesController < ApplicationController

  before_filter :authenticate_user!

  def show
    @items = current_user.items
  end
end
