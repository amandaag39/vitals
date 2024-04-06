# app/controllers/open_ai_chats_controller.rb

class OpenAiChatsController < ApplicationController
    before_action :authenticate_user!
  
    def new
    end
  
    def analyze_user_data
      numerical_vital_name = params[:numerical_vital_name]
      text_vital_name = params[:text_vital_name]
      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date
    
      # Initialize and prepare user data
      data_service = UserDataService.new(current_user, numerical_vital_name, text_vital_name, start_date, end_date)
      prepared_data = data_service.prepare_data
    
      # Initialize OpenAiChatService with the prepared data
      analysis_service = OpenAiChatService.new(numerical_vital_name, text_vital_name, prepared_data[:numerical_data], prepared_data[:text_data])
    
      # Call analyze method on the service
      @analysis_result = analysis_service.analyze
  
      render :new
    end
end
  