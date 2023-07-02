require 'telegram/bot'
require 'httparty'

TELEGRAM_TOKEN = 
CHAT_API_KEY = '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'

Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|
    bot.listen do |message|
        response = HTTParty.post(
            'https://api.openai.com/v1/chat/completions',
            headers: {
                'Authorization' => "Bearer #{CHAT_API_KEY}",
                'Content-Type' => 'application/json'
            },
            body: {
                'model' => 'text-davinci-003',
                'messages' => [{'role' => 'system', 'content' => 'You are a bot'}, {'role' => 'user', 'content' => message.text}]
        }.to_json
        )

        bot.api.send_message(chat_id: message.chat_id, text: response['choices'][0]['message']['content'])
    end
end