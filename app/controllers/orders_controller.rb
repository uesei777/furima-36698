class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index
    @order_information = OrderInformation.new
    @item = Item.find(params[:item_id])

    if (@item.user_id == current_user.id) || (@item.order != nil)
      redirect_to root_path
    end
  end

  def create
    @order_information = OrderInformation.new(order_params)
    if @order_information.valid?
      @order_information.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_information).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
