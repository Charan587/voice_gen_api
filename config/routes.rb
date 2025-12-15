require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :voice_requests, only: [:index, :show]
  post '/generate_voice', to: 'voice_requests#create'
  get '/generate_speech', to: 'audio#generate_speech'
end

