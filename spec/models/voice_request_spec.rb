require 'rails_helper'

RSpec.describe VoiceRequest, type: :model do
  it 'is valid with valid attributes' do
    vr = VoiceRequest.new(text: 'Test', status: 'pending')
    expect(vr).to be_valid
  end

  it 'is invalid without text' do
    vr = VoiceRequest.new(status: 'pending')
    expect(vr).not_to be_valid
  end

  it 'is invalid without status' do
    vr = VoiceRequest.new(text: 'Test')
    expect(vr).not_to be_valid
  end

  it 'supports status enum transitions' do
    vr = VoiceRequest.create!(text: 'Test', status: 'pending')
    vr.processing!
    expect(vr.status).to eq('processing')
  end
end

