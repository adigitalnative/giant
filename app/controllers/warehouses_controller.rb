class WarehousesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @items = Item.all
  end

end
