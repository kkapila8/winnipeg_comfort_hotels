class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user      = current_user
    @provinces = Province.order(:name)
  end

  def update
    @user      = current_user
    @provinces = Province.order(:name)
    if @user.update(profile_params)
      flash[:success] = 'Profile updated successfully.'
      redirect_to profile_path
    else
      flash.now[:error] = 'Could not update profile.'
      render :edit, status: :unprocessable_content
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :phone, :address, :city, :postal_code, :province_id)
  end
end
