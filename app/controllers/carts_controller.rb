class CartsController < ApplicationController
  def show
    @cart_items = build_cart_items
    @subtotal   = @cart_items.sum { |i| i[:subtotal] }
  end

  def add_item
    room = Room.find(params[:room_id])
    qty  = [params[:quantity].to_i, 1].max

    if current_cart[room.id.to_s]
      current_cart[room.id.to_s]["quantity"] += qty
    else
      current_cart[room.id.to_s] = {
        "room_id"  => room.id,
        "name"     => room.name,
        "price"    => room.current_price.to_f,
        "quantity" => qty
      }
    end

    session[:cart] = current_cart
    flash[:success] = "#{room.name} has been added to your cart!"
    redirect_back fallback_location: rooms_path
  end

  def update_item
    room_id = params[:room_id].to_s
    qty     = params[:quantity].to_i

    if qty > 0 && current_cart[room_id]
      current_cart[room_id]["quantity"] = qty
      session[:cart] = current_cart
      flash[:success] = "Cart updated successfully."
    else
      flash[:error] = "Invalid quantity."
    end
    redirect_to cart_path
  end

  def remove_item
    current_cart.delete(params[:room_id].to_s)
    session[:cart] = current_cart
    flash[:success] = "Item removed from your cart."
    redirect_to cart_path
  end

  private

  def build_cart_items
    current_cart.map do |room_id, item|
      room = Room.find_by(id: room_id)
      next unless room
      {
        room:     room,
        quantity: item["quantity"],
        price:    item["price"],
        subtotal: item["price"] * item["quantity"]
      }
    end.compact
  end
end