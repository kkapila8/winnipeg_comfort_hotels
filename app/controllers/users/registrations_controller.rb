class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @provinces = Province.all.order(:name)
    super
  end

  def create
    @provinces = Province.all.order(:name)
    super
  end

  def edit
    @provinces = Province.all.order(:name)
    super
  end
end