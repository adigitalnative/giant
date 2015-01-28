class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin_only
    unless current_user.roles.include?("Admin")
      flash[:alert] = "Sorry, only admin can access that area"
      redirect_to root_path
    end
  end
end
