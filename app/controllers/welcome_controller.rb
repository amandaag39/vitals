class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      render 'welcome/logged_in'
    end
  end
end
