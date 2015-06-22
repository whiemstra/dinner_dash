class CategoriesController < ApplicationController
  # def show
  #   @category = Category.find(params[:id])
  #   @categories = Category.all
  # end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    if current_user && current_admin?
      @category_items = @category.items
    else
      @category_items = @category.items.available
    end
  end
end
