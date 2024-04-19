class ApplicationController < ActionController::Base
    include Pagy::Backend

    # e.g. application_controller.rb
    # def pagy_calendar_period(collection)
    #     return_period_array_using(collection)
    # end
    
    # e.g. application_controller.rb
    # def pagy_calendar_filter(collection, from, to)
    #     return_filtered_collection_using(collection, from, to)
    # end

    include Pundit

    # Optional: Uncomment to ensure Pundit is used in every action.
    # after_action :verify_authorized, except: :index
    # after_action :verify_policy_scoped, only: :index

    before_action :authenticate_user!

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
        flash[:alert] = "Tsk Tsk. You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
    end
end
