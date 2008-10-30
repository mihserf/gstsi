class AdminController < ApplicationController
  before_filter :admin_required, :only => :index
  
  def login
    if request.post?
      login = params[:login]
      password = params[:password]
      if login == "admin" && password == "gstseminars"
        session[:admin]=true
        redirect_to "/"
      else
        redirect_to :back
      end
    end
  end
  
  def logout
    session[:admin]=false
    redirect_to :back
  end

  def index
  end

end
