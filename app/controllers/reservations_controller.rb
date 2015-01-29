class ReservationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @item = Item.find(params[:item_id])
    @reservation = @item.reservations.new(params[:reservation])
  end

  def create
    @item = Item.find(params[:item_id])
    @reservation = @item.reservations.new(params[:reservation])
    @reservation.user_id = current_user.id
    if @reservation.save
      flash[:notice] = "Reservation request submitted"
      redirect_to warehouse_item_path(@item.id)
    else
      raise "Fubar"
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @reservation = @item.reservations.find(params[:id])

    if @reservation.status.name == "Approved"
      flash[:alert] = "Sorry, you cannot edit approved requests."
      redirect_to warehouse_item_path(@item.id)
    end

    if @reservation.status.name == "Denied"
      flash[:alert] = "Sorry, you cannot edit denied requests"
      redirect_to warehouse_item_path(@item.id)
    end
  end

  def update
    @item = Item.find(params[:item_id])
    @reservation = @item.reservations.find(params[:id])

    if @reservation.update_attributes(params[:reservation])
      flash[:notice] = "Reservation request updated"
      redirect_to warehouse_item_path(@item.id)
    end
  end

end
