class UsersController < ApplicationController
  def new; end

  def create
    @user = User.new(user_params)
    @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/register', notice: 'An error occured! Please try again.'
    end
  end  
  
  private

  def user_params
    params
    .require(:user)
    .permit(
      :first_name, 
      :last_name, 
      :email, 
      :password, 
      :password_confirmation
    )
  end
end