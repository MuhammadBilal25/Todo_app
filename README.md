# 📝 To-Do App

A simple and elegant To-Do List application built with **Flutter**, **Firebase**, and REST APIs.

## 🚀 Features

- ✅ Add, update, and delete tasks
- 🕒 Set reminders with date and time
- 🧠 Firebase Authentication (Email & Password)
- 👤 Fetch user profile via REST API
- ☁️ Store tasks in Firebase Firestore
- 📱 Responsive design (Android & iOS)
- 🎨 Clean and minimal UI with Drawer Navigation

## 🔐 Authentication

- Firebase Authentication is used to securely register and authenticate users.
- Users can **sign up** and **log in** with their email and password.
- Authentication is integrated using Firebase Auth SDK.

## 🌐 REST API Integration

- After user login, their **profile data** is fetched via a REST API call.
- This simulates a real-world backend service that returns authenticated user information.
- You can easily extend this to retrieve settings, preferences, or activity history.

## 🛠️ Tech Stack

- **Flutter** (UI Framework)
- **Firebase Auth** (User Authentication)
- **Firebase Firestore** (Cloud Database)
- **REST API** (User Profile Fetching)
- **Provider / Riverpod** (State Management)
- **Dart** (Programming Language)

## 🧪 Getting Started

### Prerequisites

- Flutter SDK
- Firebase Project with Authentication and Firestore enabled
- Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files

### Installation

```bash
git clone https://github.com/MuhammadBilal25/to_do_app.git
cd to_do_app
flutter pub get
flutter run
📁 Project Structure

lib/
├── features/
│   ├── auth/
│   │   ├── controller/
│   │   ├── view/
│   └── todo/
│       ├── controller/
│       ├── model/
│       ├── repo/
│       └── view/
├── services/
│   └── firebase_service.dart
├── splash/
├── app/
│   ├── router.dart
│   └── theme/
└── main.dart
🙋‍♂️ Author
GitHub: @MuhammadBilal25

