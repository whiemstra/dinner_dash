class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    find_item
  end

  def new
    @item = Item.new
  end

  def edit
    find_item
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      flash[:error] = 'Title, Description, and Price must be present.'
      render :new
    end
  end

  def update
    find_item

    if @item.update_attributes(item_params)
      redirect_to @item
    end
  end

  def destroy
    find_item
    @item.destroy
    redirect_to items_path, notice: 'Item was successfully deleted.'
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end



