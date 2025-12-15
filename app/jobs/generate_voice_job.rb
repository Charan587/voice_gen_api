class GenerateVoiceJob < ApplicationJob
  queue_as :default

  def perform(voice_request_id)
    voice_request = VoiceRequest.find(voice_request_id)

    voice_request.update!(status: "processing")

    # 1️⃣ Generate MP3 binary from ElevenLabs
    audio_binary = ElevenLabsService.new(voice_request.text).generate_audio

    # 2️⃣ Upload to Cloudinary
    audio_url = StorageService.upload(audio_binary)

    # 3️⃣ Persist success
    voice_request.update!(
      status: "completed",
      audio_url: audio_url
    )

  rescue => e
    voice_request.update!(
      status: "failed",
      error_message: e.message
    )
    raise e
  end
end

