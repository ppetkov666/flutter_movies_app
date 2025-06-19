# Movies App (Flutter Interview Project)

This is a movie listing app built with Flutter as part of a technical interview task. 
The goal was to demonstrate practical implementation of clean architecture using MVVM, 
real Firebase integration, Provider for state management, and reusable UI components.

The app includes features like Firebase Authentication, Firestore watch list, 
error handling via modal dialogs, and pagination. The structure is modular, 
easy to maintain, and aimed at reflecting real-world app development practices.

---

## Contents

- [Features](#features)
- [Architecture Overview](#architecture-overview)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)

---

## Features

- Login and signup using Firebase Authentication (email & password)
- Secure session handling with route-based navigation
- Save/remove favorite movies per user in Firestore
- Upcoming movies list fetched from an API
- Scroll-based pagination to load more content
- MVVM pattern used throughout the app
- Global error handling via modal dialogs
- Form-level validation for email/password fields
- Clean routing setup using `onGenerateRoute`
- Modular and reusable widgets
- Firebase configured via `firebase_options.dart`

---

## Architecture Overview

The app is organized in multiple layers to separate concerns:

- **Presentation Layer:** All UI code, screens, widgets, and view models
- **Domain Layer:** Core entities like `Movie`, `Failure`, and abstract repository interfaces
- **Data Layer:** Handles API calls, DTOs, and integration with Firebase and HTTP
- **Core Layer:** Shared logic like error handling (`QueryExecutor`), constants, and navigation

Each screen is connected to a ViewModel and handles only the presentation logic. 
All API and Firebase calls are abstracted away from the UI.

---

## Technology Stack

- Flutter (3.10+)
- Dart (null-safe)
- Firebase Authentication (Email/Password)
- Cloud Firestore (user-based watch list)
- Provider (for state management)
- HTTP package (for fetching movies)
- MVVM + simplified Clean Architecture
- Reusable UI components
- Modal-based global error system
- Custom routing via `onGenerateRoute`

---

## Getting Started

### What you need first:

- Flutter SDK (3.10 or later)
- Firebase CLI installed (`npm install -g firebase-tools`)
- A Firebase project with:
  - Email/Password Authentication enabled
  - Firestore enabled

### Setup steps:

1. **Clone the repo:**

   ```bash
   git clone https://github.com/ppetkov666/flutter_movies_app.git
