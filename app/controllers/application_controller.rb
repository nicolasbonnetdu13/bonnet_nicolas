class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :avatar) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :avatar) }
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def current_user
    super || guest_user
  end
  
  private
  
  def guest_user
    
    begin
      @user = User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = 1 : session[:guest_user_id])
    rescue
      @user = User.find(session[:guest_user_id] = create_guest_user.id)
    ensure
      @user
    end
    
  end
  
  def create_guest_user
      u = User.create(:username => "guest", :roles => ["guest"])
      u.save(:validate => false)
      u
  end
    
end
