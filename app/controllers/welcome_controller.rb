class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  # Interesting! Maybe separate the landing page for logged in users and non-logged in users into two actions?
  def index
    if user_signed_in?
      render 'welcome/logged_in'
    end

  end
end
