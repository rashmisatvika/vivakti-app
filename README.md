# Vivakti — Service Marketplace App

A Flutter app for discovering and booking service providers (plumbers, electricians,
consultants, creatives, etc.), with AI-assisted service matching, in-app payments,
and secure video calls.

## Tech Stack

| Layer          | Technology                      |
|----------------|----------------------------------|
| Frontend       | Flutter (Neumorphic UI)          |
| Backend        | Python (FastAPI) + Rust          |
| Database       | SurrealDB                        |
| Payments       | Razorpay                         |
| Realtime       | Firebase / Socket.IO             |
| Video Call     | Agora.io / Twilio Video          |
| Authentication | Firebase Auth or custom JWT      |
| Location       | Google Maps API                  |

## Getting Started

1. Install [Flutter](https://docs.flutter.dev/get-started/install) (SDK >=2.17.0 <3.0.0).
2. From the project root:
   ```bash
   flutter pub get
   flutter run
   ```
3. Point the app at your backend by editing `Constants.baseUrl` in
   `lib/utils/constants.dart`.

## What's included

- `lib/main.dart` — app entry point (Neumorphic theme, starts at `WelcomeScreen`)
- `lib/screens/` — welcome → phone entry → OTP verification → category selection → home
- `lib/models/` — `AppUser`, `Service`, `AppTransaction`, `Review` (mirrors the SurrealDB schema)
- `lib/services/api_service.dart` — HTTP client stubs for `/auth/send-otp`,
  `/auth/verify-otp`, `/ai/detect-service`
- `lib/utils/` — theme and shared constants (colors, category list)

## Still to build (see the architecture plan for details)

- Service provider selection & online/offline choice screens
- Razorpay payment screen and wallet/commission split logic
- Agora/Twilio video call screen with screenshot-block + watermark
- OTP-at-arrival flow for offline services
- Feedback/rating screen and `reviews` write-back
- SurrealDB schema scripts and FastAPI backend boilerplate

## Backend (SurrealDB tables)

```sql
users        { id, phone, name?, location, created_at }
services     { id, title, category, description, is_online, price }
transactions { id, user_id, service_id, amount, status, payment_method, created_at }
reviews      { id, rating, comment?, user_id, service_id, created_at }
```

## Notes

- `razorpay_flutter`, `agora_rtc_engine`, and `flutter_secure_screen` are declared in
  `pubspec.yaml` but not yet wired into a screen — add the payment and video-call
  screens per the architecture plan, then hook them up.
- `Constants.baseUrl` is a placeholder — replace with your deployed API URL.
