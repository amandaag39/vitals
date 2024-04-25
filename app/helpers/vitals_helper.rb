module VitalsHelper
  def chart_title(time_frame)
    case time_frame
    when "all"
      "All Time Data"
    else
      "Data Overview"
    end
  end
end
