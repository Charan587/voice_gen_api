class VoiceRequestsController < ApplicationController

  # POST /generate_voice
  def create
    vr = VoiceRequest.create!(
      text: params[:text],
      status: "pending"
    )

    GenerateVoiceJob.perform_later(vr.id)

    render json: { id: vr.id, status: vr.status }, status: :accepted
  end


  # GET /voice_requests
  def index
    voice_requests = VoiceRequest.order(created_at: :desc)
    render json: voice_requests
  end

  # GET /voice_requests/:id
  def show
    voice_request = VoiceRequest.find(params[:id])
    render json: voice_request
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'VoiceRequest not found' }, status: :not_found
  end
end

