class Admin::ItemsController < Admin::BaseController
  include ApplicationHelper

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all

    @categories = Category.all
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
      flash[:success] = 'Item was successfully created.'
      redirect_to @item
    else
      # flash[:error] = 'Title, Description, and Price must be present.'
      render :new
    end
  end

  def update
    if @item.update_attributes(item_params)
      flash[:success] = "Item was successfully updated."
      redirect_to @item
    end
  end

  def destroy
    @item.destroy
    flash[:success] = "Item was successfully deleted."
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end



