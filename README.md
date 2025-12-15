Voice Generation API (Async Text-to-Speech)
===========================================

A production-ready **asynchronous Text-to-Speech API** built with **Ruby on Rails**, **Sidekiq**, and **Cloudinary**.

This system accepts text input, generates speech using ElevenLabs, stores audio in the cloud, and exposes a public playback URL.

🏗️ Architecture
----------------

`   Client    ↓  Rails API    ↓  PostgreSQL (state)    ↓  Sidekiq Worker    ↓  ElevenLabs TTS    ↓  Cloudinary Storage    ↓  Public Audio URL   `

✨ Features
----------

*   Async voice generation (non-blocking)
    
*   Background job processing with Sidekiq
    
*   Cloud audio storage (Cloudinary)
    
*   Status tracking (pending → processing → completed / failed)
    
*   Fully tested with RSpec
    
*   Deployable to Railway
    

🧠 Design Decisions
-------------------

### Why Async?

Text-to-Speech APIs are slow and unpredictable.Using Sidekiq prevents request timeouts and improves reliability.

### Why Cloudinary?

*   Free tier
    
*   Public URLs
    
*   Simple API
    
*   No S3 IAM complexity
    

### Why not React?

Deliberate scope control.Focus is backend architecture, not UI complexity.

🔌 API Endpoints
----------------

### Create Voice Request

`   POST /generate_voice  Content-Type: application/json  {    "text": "Hello world"  }   `

**Response**

`   {    "id": 1,    "status": "pending"  }   `

### Fetch Voice Request Status

`   GET /voice_requests/:id   `

**Response (completed)**

`   {    "id": 1,    "text": "Hello world",    "status": "completed",    "audio_url": "https://res.cloudinary.com/.../audio.mp3"  }   `

🧪 Testing
----------

Run the full test suite:

`   bundle exec rspec   `

Tests cover:

*   Model validations
    
*   API request lifecycle
    
*   Job state transitions
    
*   External API mocking (WebMock)
    

🚀 Getting Started (Local Setup)
--------------------------------

### 1️⃣ Clone the Repository

`   git clone https://github.com//voice_gen_api.git  cd voice_gen_api   `

### 2️⃣ Install Dependencies

`   bundle install   `

### 3️⃣ Set Environment Variables

Create a .env file (or export manually):

`   RAILS_ENV=development  ELEVENLABS_API_KEY=your_elevenlabs_key  CLOUDINARY_URL=cloudinary://api_key:api_secret@cloud_name  REDIS_URL=redis://localhost:6379/0  DATABASE_URL=postgres://localhost/voice_gen_api_development   `

### 4️⃣ Setup Database

`   bin/rails db:create db:migrate   `

### 5️⃣ Start Redis

`   redis-server   `

### 6️⃣ Start Sidekiq

`   bundle exec sidekiq   `

### 7️⃣ Start Rails Server

`   bin/rails server   `

App will be available at:

`   http://localhost:3000   `

☁️ Deployment (Railway)
-----------------------

1.  Push code to GitHub
    
2.  Create new Railway project
    
3.  Add:
    
    *   PostgreSQL
        
    *   Redis
        
4.  RAILS\_ENV=productionSECRET\_KEY\_BASE=generated\_valueELEVENLABS\_API\_KEY=...CLOUDINARY\_URL=...
    
5.  Enable Sidekiq worker
    
6.  Deploy 🚀
