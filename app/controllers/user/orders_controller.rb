class User::OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    order = Order.new(order_params)
    if order.save
      @cart.contents.each_pair do |item_id, quantity|
        order.item_orders.create(item_id: item_id.to_i, quantity: quantity)
      end
      order.item_orders.create()
      flash[:success] = "Order Successfully Placed. Thank You!"
      redirect_to user_order_path(order)
    else
      flash[:errors] = "Please Try Again."
      redirect_to checkout_path
    end
    @cart.clear_cart
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :subtotal, :item_id)
  end
end
