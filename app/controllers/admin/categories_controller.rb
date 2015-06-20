class Admin::CategoriesController < Admin::BaseController
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

  def destroy
    category = Category.find(params[:id])
    category.destroy

    flash.notice = "#{category.title} was deleted!"
    redirect_to admin_categories_path
  end
  private

  def category_params
    params.require(:category).permit(:title)
  end
end
