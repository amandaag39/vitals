module VitalsHelper
  def chart_title(time_frame)
    case time_frame
    when 'all'
      "All Time Data"
    when '2_weeks'
      "Last 2 Weeks"
    when '6_months'
      "Last 6 Months"
    when '1_year'
      "Last Year"
    else
      "Data Overview"
    end
  end
end
