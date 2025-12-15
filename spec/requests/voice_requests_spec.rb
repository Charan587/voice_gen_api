require 'rails_helper'

RSpec.describe "VoiceRequests API", type: :request do

  describe "POST /generate_voice" do
    it "creates a voice request with valid input" do
      post "/generate_voice", params: { text: "Hello API" }

      expect(response).to have_http_status(:accepted)
      body = JSON.parse(response.body)

      expect(body["status"]).to eq("pending")
      expect(body["id"]).not_to be_nil
    end

    it "returns error when text is missing" do
      post "/generate_voice", params: {}

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /voice_requests" do
    it "returns voice request history" do
      VoiceRequest.create!(text: "Test", status: "pending")

      get "/voice_requests"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /voice_requests/:id" do
    it "returns a single voice request" do
      vr = VoiceRequest.create!(text: "Test", status: "pending")

      get "/voice_requests/#{vr.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns 404 for missing record" do
      get "/voice_requests/99999"
      expect(response).to have_http_status(:not_found)
    end
  end
end

