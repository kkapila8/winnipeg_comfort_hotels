ActiveAdmin.setup do |config|
  config.site_title = "Winnipeg Comfort Hotels Admin"

  # Feature 1.1 - Admin authentication using Devise User model
  config.authentication_method = :authenticate_user!
  config.current_user_method   = :current_user
  config.logout_link_path      = :destroy_user_session_path
  config.logout_link_method    = :delete

  config.root_to = "dashboard#index"

  config.batch_actions = true

  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]

  config.localize_format = :long
end