class CartItemsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart_items] = @cart.contents

    flash[:notice] = "You now have #{pluralize(@cart.count_of(item.id), item.title)} in your cart_items."
    redirect_to root_path
  end
end
