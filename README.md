# Week 5 - Movie App with Theming, Pagination, Caching & Error Logging

## 📋 Overview

A Flutter application demonstrating key development concepts including theming, pagination, caching, error logging, and state management with Cubit.

## 🎯 Features Implemented

### ✅ Light & Dark Theming
- Theme manager with SharedPreferences for persistence
- Manual toggle button in the app bar
- Full light and dark theme support

### ✅ Pagination
- "Load More Movies" button pagination
- Automatic page tracking
- State management for loading more

### ✅ Caching
- Hive-based local storage
- JSON serialization for model caching
- Cache expiry (24 hours)
- Offline support

### ✅ Error Logging
- Firebase Crashlytics integration
- Error logging for network errors
- Error logging for runtime errors

### ✅ API Integration
- Retrofit for network calls
- JSON serialization for models
- Repository pattern implementation
- Cubit state management

## 🏗️ Architecture

```
lib/
├── core/
│   ├── di/                    # Dependency Injection
│   ├── network/               # Network configuration
│   ├── routes/                # App routing
│   ├── theme/                 # Theme management
│   ├── utils/                 # Utilities (Crashlytics)
│   └── widgets/               # Reusable widgets
├── features/
│   └── movies/
│       ├── data/
│       │   ├── models/        # Data models
│       │   ├── datasources/   # API & Local data sources
│       │   └── repository/    # Repository implementation
│       └── presentation/
│           ├── cubit/         # State management (Cubit)
│           └── screens/       # UI screens
└── main.dart                  # App entry point
```

## 📦 Dependencies

- `dio` - HTTP client
- `retrofit` - Type-safe HTTP client
- `flutter_bloc` - State management
- `hive` & `hive_flutter` - Local caching
- `json_annotation` & `json_serializable` - JSON serialization
- `firebase_core` & `firebase_crashlytics` - Error logging
- `cached_network_image` - Image caching
- `shared_preferences` - Theme persistence

## 🚀 Getting Started

### Prerequisites

1. Flutter SDK installed
2. Firebase project set up
3. TMDB API key

### Setup Instructions

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate code:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Firebase Setup:**
   - Add your `google-services.json` (Android) to `android/app/`
   - Add your `GoogleService-Info.plist` (iOS) to `ios/Runner/`
   - Update Firebase configuration in `pubspec.yaml` if needed

4. **TMDB API Key:**
   - Update `api_constants.dart` with your TMDB API key
   - Or replace the existing key with your own

5. **Run the app:**
   ```bash
   flutter run
   ```

## 💾 Caching Strategy

- Movies list cached for 24 hours
- Movie details cached indefinitely (until cleared)
- Cache cleared when expired
- Offline fallback to cached data

## 📊 API Integration

Using TMDB API:
- Endpoint: `/movie/popular`
- Pagination support
- Image support
- Error handling

## 🐛 Error Logging

Firebase Crashlytics integrated for:
- Network errors
- Runtime errors
- User actions (logs)
