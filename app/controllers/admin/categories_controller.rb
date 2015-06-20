class Admin::CategoriesController < Admin::BaseController
  include ApplicationHelper

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to admin_categories_path
    else
      flash.now[:erros] = category.errors.full_messages.join(", ")
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
      render :edit
      redirect_to admin_categories_path
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:success] = "Category was deleted!"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = Category.find(params[:id])
  end

 end
