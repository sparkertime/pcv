class SessionsController < ApplicationController
  def new
  end

  def create
    self.current_user = User.authenticate(params[:username], params[:password])

    respond_to do |format|
      if logged_in?
        flash[:notice] = "Thanks for logging in!"
        format.html { redirect_to(feeds_path) }
      else
        flash[:notice] = "No matching username/password found"
        format.html { redirect_to(new_session_path) }
      end
    end
  end

  def end
    self.current_user = nil
    respond_to do |format|
      format.html { redirect_to(root_path) }
    end
  end
end
