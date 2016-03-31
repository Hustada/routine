class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user,   only: [:edit, :update]

  def index
  end

  def show  
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "Welcome #{@user.name}! Lets Get Pumped Up!"
  		redirect_to root_path
  	else
  		render new
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
    	flash[:success] = "Something was updated......I think"
    	redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

  private

 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end

 def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url)  unless current_user?(@user)
 end

end