# challenge

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Architecture and Design Choices

1. Which patterns/libraries did you use and why?

Bloc (flutter_bloc): Used for state management to separate business logic from UI, making the app more scalable and testable.

SharedPreferences: Used for local storage to persist the last prime number timestamp, ensuring elapsed time is correctly calculated even after restarting the app.

Dart Timer class: Used to periodically fetch new numbers, ensuring automatic updates without user interaction.

Functional Error Handling (Either from dartz): Ensures better error handling when fetching numbers, preventing crashes.

Dependency Injection: The NumberBloc receives dependencies (GetRandomNumber and LocalStorageService) via constructor injection, making it easier to test and maintain.

2. What assumptions did you make that influenced your design?

The app should function correctly even after being restarted, so we persist the last prime timestamp using SharedPreferences.

Numbers should be fetched automatically every 10 seconds, leading to the use of Timer.periodic inside NumberBloc.

Handling edge cases, such as the app being closed mid-update, ensuring that the stored timestamp correctly reflects the last prime found.

The app may need to scale in the future, so we use Bloc for predictable state management and maintainable code.