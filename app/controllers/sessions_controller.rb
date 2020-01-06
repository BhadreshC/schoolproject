class SessionsController < ApplicationController
 
  def new   
  end   
  def create   
    principle = Principle.find_by_email(params[:email])   
    if principle && principle.authenticate(params[:password])   
      session[:principle_id] = principle.id   
      redirect_to root_url, notice: 'Wel come to Dashboard '   
    else   
      render :new   
    end   
  end   
  def destroy   
    session[:principle_id] = nil   
    redirect_to root_url, notice: 'Logged out!'   
  end   
end
