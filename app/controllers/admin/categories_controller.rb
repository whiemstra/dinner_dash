class Admin::CategoriesController < Admin::BaseController
  include ApplicationHelper

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      flash[:success] = "Category has been successfully created."
      redirect_to admin_categories_path
    else
      flash[:errors] = category.errors.full_messages.join(", ")
      redirect_to admin_categories_path
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Category has been successfully updated."
      redirect_to admin_categories_path
    else
      flash.now[:errors] = @category.errors.full_messages.join(", ")
      render :edit
      # redirect_to admin_categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
