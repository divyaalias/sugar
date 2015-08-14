class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_action :authenticate_user!
  def after_sign_in_path_for(resource)
    #important - this action will be run during sign-up and sign-in as well, so conditions are necessary.
   # if resource.is_a?(User)
      signed_in_root_path(resource)
   # end
  end

end
