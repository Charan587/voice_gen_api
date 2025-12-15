class VoiceRequest < ApplicationRecord
  validates :text, presence: true
  validates :status, presence: true

  enum status: {
    pending: 'pending',
    processing: 'processing',
    completed: 'completed',
    failed: 'failed'
  }
end

