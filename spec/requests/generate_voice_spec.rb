require "rails_helper"

RSpec.describe "Generate Voice API", type: :request do
  it "creates a voice request" do
    post "/generate_voice", params: { text: "Hello world" }

    expect(response).to have_http_status(:accepted)

    body = JSON.parse(response.body)
    expect(body).to have_key("id")
  end
end
