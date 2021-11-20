class VoiceReportController < ApplicationController
  def report
    message = "Greetings to the logged user.
    There are currently #{Elevator.count} elevators deployed in the #{Building.count} buildings of your #{Customer.count} customers.
    Currently, #{Elevator.where.not(status: 'Intervention').count} elevators are not in Running Status and are being serviced.
    You currently have #{Quote.count} quotes awaiting processing.
    You currently have #{Lead.count} leads in your contact requests.
    #{Battery.count} Batteries are deployed across #{Address.distinct.count(:city)} cities.
    "
    response = client.synthesize_speech input: {'text': message}, voice: {'language_code': 'en-US'}, audio_config: {'audio_encoding': 'MP3'}
    print response
    File.open Rails.root.join(
      'public',
      'output',
      "#{'output'}.#{'mp3'}"
    ),
      'wb' do |file|
        file.write response.audio_content
    end
    send_data response
  end

  def client
    Google::Cloud::TextToSpeech.text_to_speech
  end

  def voice
    {language_code: 'en-US'}
  end

  def audio
    {audio_encoding: 'MP3'}
  end

end
