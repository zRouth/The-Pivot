class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_id(params[:id])
    redirect_to categories_path unless @category
  end

  def edit
    @category = Category.find_by_id(params[:id])
  end

  def update
    @category = Category.find_by_id(params[:id])
    @category.update(correct_params)
    redirect_to category_path(@category)
  end

  def new
    @category = Category.new
  end

  def create
    Category.create correct_params
    redirect_to categories_path
  end

  def destroy
    category = Category.find_by_id(params[:id])
    category.delete if category
    redirect_to categories_path
  end

  def correct_params
    params.require(:category).permit(:title)
  end
end
