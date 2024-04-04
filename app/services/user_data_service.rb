# app/services/user_data_service.rb

class UserDataService
    def initialize(user, numerical_vital_name, text_vital_name, start_date, end_date)
      @user = user
      @numerical_vital_name = numerical_vital_name
      @text_vital_name = text_vital_name
      @start_date = start_date
      @end_date = end_date
    end
  
    def prepare_data
      numerical_data = fetch_numerical_data.to_a
      text_data = fetch_text_data.to_a
      
      Rails.logger.debug "Numerical Data: #{numerical_data.inspect}"
      Rails.logger.debug "Text Data: #{text_data.inspect}"
      
      { numerical_data: numerical_data, text_data: text_data }
    end
  
    private
  
    def fetch_numerical_data
      @user.readings.joins(:vital)
           .where(vitals: { name: @numerical_vital_name, category: :numerical }, readings: { measured_at: @start_date..@end_date })
           .select('readings.measured_at, readings.numeric_reading')
           .order('readings.measured_at ASC')
    end
  
    def fetch_text_data
      @user.readings.joins(:vital)
           .where(vitals: { name: @text_vital_name, category: :text }, readings: { measured_at: @start_date..@end_date })
           .select('readings.measured_at, readings.text_reading')
           .order('readings.measured_at ASC')
    end
  end
  