# 🎙️ Voice Generation API (Async Text-to-Speech)

A production-ready **asynchronous Text-to-Speech API** built with **Ruby on Rails**, **Sidekiq**, and **Cloudinary**.

This system accepts text input, generates speech using ElevenLabs, stores audio in the cloud, and exposes a public playback URL.

---

## 🏗️ Architecture

Client
  ↓
Rails API
  ↓
PostgreSQL (state)
  ↓
Sidekiq Worker
  ↓
ElevenLabs TTS
  ↓
Cloudinary Storage
  ↓
Public Audio URL

---

## ✨ Features

- Async voice generation (non-blocking)
- Background job processing with Sidekiq
- Cloud audio storage (Cloudinary)
- Status tracking (`pending → processing → completed / failed`)
- Fully tested with RSpec
- Deployable to Railway

---

## 🧠 Design Decisions

### Why Async?
Text-to-Speech APIs are slow and unpredictable.  
Using Sidekiq prevents request timeouts and improves reliability.

### Why Cloudinary?
- Free tier
- Public URLs
- Simple API
- No S3 IAM complexity

### Why not React?
Deliberate scope control.  
Focus is backend architecture, not UI complexity.

---

## 🔌 API Endpoints

### Create Voice Request
```http
POST /generate_voice
