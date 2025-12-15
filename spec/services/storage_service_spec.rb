require "rails_helper"

RSpec.describe StorageService do
  it "uploads audio and returns url" do
    allow(Cloudinary::Uploader).to receive(:upload)
      .and_return({ "secure_url" => "https://cloudinary.com/test.mp3" })

    url = StorageService.upload("FAKE_AUDIO")

    expect(url).to eq("https://cloudinary.com/test.mp3")
  end
end
