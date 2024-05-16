# nice service object! 
# app/services/open_ai_chat_service.rb

class OpenAiChatService
  def initialize(prompt)
    @prompt = prompt
  end

  def call
    client = OpenAI::Client.new
    begin
      response = client.chat(
        parameters: {
          model: "gpt-4-0125-preview",
          messages: [{ role: "user", content: @prompt }],
          temperature: 1.09,
        },
      )
      response.dig("choices", 0, "message", "content")
    rescue Faraday::ClientError => e
      puts e.message
    end
  end
end
