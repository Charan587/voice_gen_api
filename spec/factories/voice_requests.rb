FactoryBot.define do
  factory :voice_request do
    text { "MyText" }
    status { "MyString" }
    audio_url { "MyString" }
    error_message { "MyText" }
  end
end
