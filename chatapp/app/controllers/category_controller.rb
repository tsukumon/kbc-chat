class CategoryController < ApplicationController
  def index
    @category = Room.all
    @category = @category.where(category: params[:id])
    p @category
  end
end
