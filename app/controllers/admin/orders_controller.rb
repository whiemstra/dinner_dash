class Admin::OrdersController < Admin::BaseController

  def show
    @order = Order.find_by(id: params[:id].to_i)
  end

  def update
    order = Order.find_by(id: params[:order_id].to_i)
    if order.update(status: params[:status])
      flash[:notice] = "Order #{order.id} status changed to #{params[:status]}"
      redirect_to admin_order_path(order)
    else
      flash[:errors] = order.errors.full_messages.join(", ")
      redirect_to admin_order_path(order)
    end
  end

  def status
    @orders = Order.all
    @statuses = ["ordered", "paid", "completed", "cancelled"]
    render :status
  end
end
