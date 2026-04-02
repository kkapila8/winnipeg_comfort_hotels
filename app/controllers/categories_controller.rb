class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @rooms    = @category.rooms.available.page(params[:page]).per(9)
    @breadcrumbs = [
      { name: "Home", path: root_path },
      { name: @category.name, path: nil }
    ]
  end
end