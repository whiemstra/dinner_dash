class Admin::ItemsController < Admin::BaseController
  include ApplicationHelper

  before_action :set_item, only: [:show, :edit, :update]

  # def index
  #   @items = Item.all
  #   @categories = Category.all
  # end

  def index
    if current_user && current_admin?
      @items = Item.all
      @categories = Category.all
    else
      @items = Item.available
      @categories = Category.all
    end
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
      redirect_to item_path(@item)
    else
      flash[:errors] = 'Title, Description, Price, and Category must be present.'
      render :new
    end
  end

  def update
    if @item.update_item_plus_categories(item_params)
      @item.modify_status(params[:status])
      flash[:success] = "Item was successfully updated."
      redirect_to item_path(@item)
    else
      # test this.
    end
  end

  # def destroy
  #   @item.destroy
  #   flash[:success] = "Item was successfully deleted."
  #   redirect_to items_path
  # end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :status, :category_ids => [])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end



