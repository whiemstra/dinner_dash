class CartItemsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart_items] = @cart.contents

    flash[:success] = "You now have #{pluralize(@cart.count_of(item.id), item.title)} in your cart_items."
    redirect_to root_path
  end

  def destroy
    item = Item.find(params[:id])
    @cart.contents.delete(params[:id])
    flash[:success] = "You have removed #{item.title} from your cart."
    redirect_to cart_items_path
  end
end
