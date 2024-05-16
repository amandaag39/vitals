# app/controllers/open_ai_chats_controller.rb

class AnalysisController < ApplicationController
  def create
    # you can use strong params here ; it is more secure and better practice
    numerical_vital_name = params[:numerical_vital_name]
    text_vital_name = params[:text_vital_name]
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date

    prompt = current_user.prompt(numerical_vital_name, text_vital_name, start_date, end_date)

    @analysis_result = OpenAiChatService.new(prompt).call

    render :new
  end
end
