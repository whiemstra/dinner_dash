class ItemsController < ApplicationController
  include ApplicationHelper

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      # flash[:error] = 'Title, Description, and Price must be present.'
      render :new
    end
  end

  def update
    if @item.update_attributes(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: 'Item was successfully deleted.'
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end



