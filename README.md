# notetakeapp

A new Flutter project.

## Getting Started
📝 notetakeapp - Flutter Bootcamp 2025 Final Project
📌 Features Checklist
✔️ Firebase Authentication (Login & Signup)
✔️ CRUD operations for notes using Firestore
✔️ State management with Provider
✔️ UI using Flutter widgets taught in the bootcamp
✔️ Organized MVVM folder structure

📌 App Functionality
notetakeapp is a simple note-taking app that allows users to:

Sign up and log in using Firebase Authentication.
Create, read, update, and delete notes using Firestore.
Maintain state using Provider for efficient UI updates.
Navigate through the app with an MVVM-based structure.

📌 Firebase Setup Guide
1>
Prepare your workspace

Install the Firebase CLI and log in (run firebase login)
Install the Flutter SDK
Create a Flutter project (run flutter create)
2>
Install and run the FlutterFire CLI
From any directory, run this command:
dart pub global activate flutterfire_cli

Then, at the root of Flutter project directory, run this command:
flutterfire configure --project=notetakeapp-18b01
This automatically registers per-platform apps with Firebase and adds a lib/firebase_options.dart configuration file to your Flutter project.
3>
To initialize Firebase, call Firebase.initializeApp from the firebase_core package with the configuration from your new firebase_options.dart file:
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

📌added dependencies
firebase_core: ^3.10.1
firebase_auth: ^5.4.1
cloud_firestore: ^5.6.2
provider: ^6.0.5
uuid: ^3.0.7
flutter pub get (To enable firebase in flutter)

📌
Enable Firebase Authentication
Go to Firebase Console → Authentication → Enable Email/Password Sign-in.
Setup Firestore Database
📌
Go to Firebase Console → Firestore Database → Create Database.
📌 Firestore Rules
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
match /notes/{userId}/{noteId} {
allow read, write: if request.auth != null && request.auth.uid == userId;
}
} } 
This ensures only logged-in users can access their own notes.




