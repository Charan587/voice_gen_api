require "faraday"
require "json"

class ElevenLabsService
  BASE_URL = "https://api.elevenlabs.io/v1"

  def initialize(text)
    @text = text
    @api_key  = Rails.application.credentials.dig(:elevenlabs, :api_key)
    @voice_id = Rails.application.credentials.dig(:elevenlabs, :voice_id)

    raise "ElevenLabs API key missing"  unless @api_key
    raise "ElevenLabs voice_id missing" unless @voice_id
  end

  def generate_audio
    payload = {
      text: @text,
      model_id: "eleven_turbo_v2_5",
      voice_settings: {
        stability: 0.0,
        similarity_boost: 1.0
      }
    }

    body = payload.to_json

    conn = Faraday.new do |f|
      f.adapter :net_http do |http|
        http.read_timeout = 60
        http.open_timeout = 10
      end
    end

    response = conn.post("https://api.elevenlabs.io/v1/text-to-speech/pNInz6obpgDQGcFmaJgB/stream") do |req|
      req.headers = {
        "xi-api-key"      => @api_key,
        "Content-Type"    => "application/json",
        "Accept"          => "audio/mpeg",
        "Content-Length"  => body.bytesize.to_s,
        "User-Agent"      => "curl/8.0.1",     # 👈 important
        "Expect"          => ""                # 👈 THIS IS THE FIX
      }
      req.body = body
    end

    unless response.status == 200
      raise "ElevenLabs API error: #{response.status} - #{response.body}"
    end

    response.body
  end


end
