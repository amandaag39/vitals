# app/services/open_ai_chat_service.rb

class OpenAiChatService
  def initialize(numerical_vital_name, text_vital_name, numerical_data, text_data)
    @numerical_vital_name = numerical_vital_name
    @text_vital_name = text_vital_name
    @numerical_data = numerical_data
    @text_data = text_data
    @prompt = construct_prompt
  end

  def analyze
    client = OpenAI::Client.new
    begin
      response = client.chat(
        parameters: {
          model: "gpt-4-0125-preview",
          messages: [{ role: "user", content: @prompt }],
          temperature: 0.7,
        })
      response.dig("choices", 0, "message", "content")
    rescue Faraday::ClientError => e
      handle_errors(e)
    end
  end

  private

  def construct_prompt
    prompt = "Analyze the following user data. Numerical readings of #{@numerical_vital_name} and textual descriptions of #{@text_vital_name}:\n\n"
    prompt += "#{@numerical_vital_name} readings:\n"
    prompt += @numerical_data.map do |entry|
      "#{entry.measured_at}: #{entry.numeric_reading}"
    end.join("\n")
    prompt += "\n\n#{@text_vital_name} descriptions:\n"
    prompt += @text_data.map do |entry|
      "#{entry.measured_at}: #{entry.text_reading}"
    end.join("\n")
    prompt += "\n\nThese are data related to my health I've gathered over time. What insights can you provide me based on the above data? Do you see any correlations between them?"
  end
end
