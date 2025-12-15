class CreateVoiceRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :voice_requests do |t|
      t.text :text
      t.string :status
      t.string :audio_url
      t.text :error_message

      t.timestamps
    end
  end
end
