require "cloudinary"
require "cloudinary/uploader"
require "stringio"

class StorageService
  def self.upload(audio_binary)
    raise "No audio data provided" if audio_binary.blank?

    Cloudinary::Uploader.upload(
      StringIO.new(audio_binary),
      resource_type: :video, # Cloudinary uses :video for audio
      public_id: "voice_#{SecureRandom.uuid}",
      format: "mp3"
    )["secure_url"]
  end
end

