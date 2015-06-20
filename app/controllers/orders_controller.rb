class OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    if order.save
      @cart.contents.each_pair do |item_id, quantity|
        order.item_orders.create(item_id: item_id.to_i, quantity: quantity)
      end
      order.item_orders.create()
      flash[:success] = "Order Successfully Placed. Thank You!"
      redirect_to order_payment_path  #TODO change to orders_payment_path or somthing once we get CC working
    else
      flash[:error] = "Please Try Again."
      redirect_to checkout_path
    end
    @cart.clear
  end

  # def payment
  # end

  private

  def order_params
    params.require(:order).permit(:user_id, :subtotal, :item_id)
  end
end
