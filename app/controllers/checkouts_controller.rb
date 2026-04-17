class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_cart_not_empty

  def show
    @provinces  = Province.order(:name)
    @province   = current_user.province || Province.find_by(code: 'MB')
    @cart_items = build_cart_items
    @subtotal   = @cart_items.sum { |i| i[:subtotal] }
    calculate_taxes(@province, @subtotal) if @province

    # Feature 3.3.1 - Create Stripe PaymentIntent in sandbox mode
    return unless @total

    intent = Stripe::PaymentIntent.create(
      amount: (@total * 100).to_i,
      currency: 'cad',
      metadata: { user_id: current_user.id }
    )
    @client_secret          = intent.client_secret
    @stripe_publishable_key = Rails.application.credentials.dig(:stripe, :publishable_key)
  end

  def create
    @provinces  = Province.order(:name)
    @province   = Province.find(params[:province_id])
    @cart_items = build_cart_items
    @subtotal   = @cart_items.sum { |i| i[:subtotal] }
    calculate_taxes(@province, @subtotal)

    order = Order.new(
      user:              current_user,
      province:          @province,
      shipping_address:  params[:address],
      shipping_city:     params[:city],
      shipping_postal:   params[:postal_code],
      province_name:     @province.name,
      gst_rate:          @province.gst,
      pst_rate:          @province.pst,
      hst_rate:          @province.hst,
      subtotal:          @subtotal,
      gst_amount:        @gst_amount,
      pst_amount:        @pst_amount,
      hst_amount:        @hst_amount,
      total:             @total,
      status:            'pending',
      stripe_payment_id: params[:stripe_payment_id]
    )

    if order.save
      @cart_items.each do |item|
        order.order_items.create!(
          room:       item[:room],
          room_name:  item[:room].name,
          unit_price: item[:price],
          quantity:   item[:quantity],
          line_total: item[:subtotal]
        )
      end

      unless current_user.full_address_present?
        current_user.update(
          address:     params[:address],
          city:        params[:city],
          postal_code: params[:postal_code],
          province:    @province
        )
      end

      # Feature 3.3.1 - Mark order as paid once Stripe confirms payment
      order.update(status: 'paid') if params[:stripe_payment_id].present?

      session[:cart] = {}

      # Feature 6.1 - Discord Bot notification on booking confirmation
      DiscordNotifier.booking_confirmed(order)

      flash[:success] = "Booking confirmed! Order ##{order.id} placed successfully."
      redirect_to order_path(order)
    else
      flash.now[:error] = 'Could not complete booking. Please check your details.'
      render :show, status: :unprocessable_content
    end
  end

  private

  def ensure_cart_not_empty
    return unless current_cart.empty?

    flash[:error] = 'Your cart is empty. Please add a room first.'
    redirect_to rooms_path
  end

  def build_cart_items
    current_cart.map do |room_id, item|
      room = Room.find_by(id: room_id)
      next unless room

      { room: room, quantity: item['quantity'],
        price: item['price'], subtotal: item['price'] * item['quantity'] }
    end.compact
  end

  def calculate_taxes(province, subtotal)
    @gst_amount = (subtotal * province.gst).round(2)
    @pst_amount = (subtotal * province.pst).round(2)
    @hst_amount = (subtotal * province.hst).round(2)
    @total      = (subtotal + @gst_amount + @pst_amount + @hst_amount).round(2)
  end
end