class ReservationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @reservation = current_user.reservations.new(params[:reservation])
    @item = Item.find(params[:item_id])
  end

end
