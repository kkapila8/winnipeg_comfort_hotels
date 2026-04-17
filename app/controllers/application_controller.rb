class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name phone address city postal_code province_id])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name phone address city postal_code province_id])
  end

  def current_cart
    session[:cart] ||= {}
  end

  def cart_count
    current_cart.values.sum { |item| item['quantity'] }
  end
  helper_method :current_cart, :cart_count
end
