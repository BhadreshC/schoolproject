class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception   
  private   
  def current_principle   
    Principle.where(id: session[:principle_id]).first   
  end   
  helper_method :current_principle  
end
