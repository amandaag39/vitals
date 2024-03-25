class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      render 'welcome/logged_in' # Renders the logged_in.html.erb view for authenticated users
    end
  end
end
