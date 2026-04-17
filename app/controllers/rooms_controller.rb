class RoomsController < ApplicationController
  def index
    @rooms = Room.available.includes(:hotel, :categories)

    @rooms = @rooms.search(params[:keyword]) if params[:keyword].present?

    @rooms = @rooms.by_category(params[:category_id]) if params[:category_id].present?

    case params[:filter]
    when 'on_sale'          then @rooms = @rooms.on_sale
    when 'new'              then @rooms = @rooms.new_arrivals
    when 'recently_updated' then @rooms = @rooms.recently_updated
    end

    @categories  = Category.order(:name)
    @total_count = @rooms.count
    @rooms       = @rooms.page(params[:page]).per(9)
  end

  def show
    @room = Room.includes(:hotel, :categories).find(params[:id])
    @breadcrumbs = [
      { name: 'Home', path: root_path },
      { name: @room.categories.first&.name || 'Rooms',
        path: @room.categories.first ? category_path(@room.categories.first) : rooms_path },
      { name: @room.name, path: nil }
    ]
  end
end
