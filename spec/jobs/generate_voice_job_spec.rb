require "rails_helper"

RSpec.describe GenerateVoiceJob, type: :job do
  let(:voice_request) do
    VoiceRequest.create!(text: "Test audio", status: "pending")
  end

  before do
    allow(ElevenLabsService).to receive_message_chain(:new, :generate_audio)
      .and_return("FAKE_MP3_BINARY")

    allow(StorageService).to receive(:upload)
      .and_return("https://cloudinary.com/fake.mp3")
  end

  it "updates status to completed" do
    described_class.perform_now(voice_request.id)

    voice_request.reload

    expect(voice_request.status).to eq("completed")
    expect(voice_request.audio_url).to eq("https://cloudinary.com/fake.mp3")
  end
end

