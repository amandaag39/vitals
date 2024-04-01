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
end
