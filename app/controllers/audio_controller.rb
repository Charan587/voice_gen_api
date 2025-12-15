class AudioController < ApplicationController
  def generate_speech
    text = params[:text] || "Hello from Rails using ElevenLabs"
    voice_id = "pNInz6obpgDQGcFmaJgB" # Adam voice (known-good)

    client = ElevenLabs::Client.new

    audio_binary = client.text_to_speech(
      voice_id,
      text,
      model_id: "eleven_turbo_v2_5",
      output_format: "mp3_44100_128",
      voice_settings: {
        stability: 0.0,
        similarity_boost: 1.0
      }
    )

    send_data audio_binary,
              type: "audio/mpeg",
              disposition: "inline",
              filename: "speech.mp3"
  rescue => e
    render plain: "Error generating speech: #{e.message}", status: 500
  end
end
