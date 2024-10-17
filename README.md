#-----------------Flutter App------------------

This Flutter project is a scalable and feature-rich mobile application that fetches all data from Firestore, providing a dynamic user experience. The app includes user authentication functionalities, allowing users to sign up, log in, and securely access personalized content. Built with clean architecture, it focuses on reusable components and seamless integration with Firebase.

#-------------Key Features----------------

1. Firestore Integration: All content and data displayed in the app are fetched in real-time from Firestore, ensuring that the latest information is available to users.
2. User Authentication: Supports user login and sign-up, with secure authentication using Firebase Authentication.
3. Custom UI Widgets: Modular and reusable UI components such as custom containers, app bars, loaders, and grid layouts.
4. Dynamic Theming: Includes custom themes with pre-defined styles for buttons, text fields, chips, and more, supporting a cohesive design across the app.
5. State Management: Efficient Get-X State management of the application's state, ensuring smooth transitions and data handling.
6. Error Handling: Robust utilities for handling network requests, exceptions, and formatting issues.
7. Device Compatibility: Optimized utilities for different devices, ensuring a consistent experience across platforms.
8. Helper Functions: Utility functions for common operations like pricing calculations, cloud interactions, and local storage management.
#-----------------Folder Structure-------------------
lib/app.dart: Application setup and initialization.
lib/main.dart: Main entry point for the Flutter app.
lib/common: Contains reusable widgets such as loaders, custom shapes, and app bars.
lib/utils: Utility files for constants, theming, network management, and exception handling.
lib/bindings: Dependency management and bindings for the app's components.


#----------------Setup Instructions---------------------

1. Clone the repository: run
git clone <repository-url>

2. Install dependencies: run
flutter pub get

3. Configure Firebase:
Add your google-services.json for Android.
Add your GoogleService-Info.plist for iOS.

4. Run the app:
flutter run
