# Flutter Clean Architecture Template with Bloc State Management

## Overview

This Flutter app template provides a ready-to-use implementation of **Clean Architecture** with **Bloc State Management (Cubit)**. It includes essential features like **Firebase Authentication**, **Firestore Database**, **Profile Management**, **Theming**, **HydratedCubit** for state persistence, and **Hive** for local data storage and caching.

## Features

- **Firebase Authentication**: Supports login and registration using Firebase.  
- **Firestore Integration**: Manage user data with Firestore Database.  
- **Profile Management**: Users can edit their profiles.  
- **Change Password**: Secure password update functionality.  
- **Hive**: Local storage and caching for offline capabilities and quick data retrieval.  
- **HydratedCubit**: Persistent state management, even after app restarts.  
- **Custom Theming**: Dynamic app themes using Cubit.

## Clean Architecture Structure

The app follows a modular approach with clear separation of concerns:  
1. **Presentation Layer**: UI components powered by Cubit.  
2. **Domain Layer**: Business logic and use cases.  
3. **Data Layer**: Repositories and data sources (e.g., Firebase).  

## Getting Started

### Prerequisites

- Install **Flutter SDK**: [Get started with Flutter](https://flutter.dev/docs/get-started).  
- Set up **Firebase** for your project: [Firebase Setup Guide](https://firebase.google.com/docs/flutter/setup).  

### Installation

1. Clone the repository:  
   ```bash
   git clone https://github.com/deswinar/Flutter-Basic-Clean-Architecture.git
   ```  
2. Navigate to the project directory:  
   ```bash
   cd flutter_basic_clean_architecture
   ```  
3. Get the dependencies:  
   ```bash
   flutter pub get
   ```  
4. Run the app:  
   ```bash
   flutter run
   ```

## Folder Structure

```plaintext
lib/
├── core/                      # Contains shared resources and utilities
│   ├── config/                # App-wide configurations
│   │   ├── app_constants.dart
│   │   ├── environment.dart   # Environment setup (staging, production, etc.)
│   ├── error/                 # Error handling logic
│   │   ├── exceptions.dart
│   │   ├── failure.dart       # For throwing catch block
│   ├── localization/               # Localization
│   ├── network/               # API client and network configurations
│   │   ├── api_client.dart
│   │   ├── cloudinary_service.dart
│   │   ├── network_info.dart
│   ├── theme/                 # App-wide theming and styles
│   │   ├── app_theme.dart
│   │   ├── theme_cubit.dart
│   │   ├── theme_state.dart
│   ├── utils/                 # General utilities
│       ├── constants.dart
│       ├── enums.dart
│       ├── route_transitions.dart
│       ├── extensions.dart
│       ├── validators.dart
│       ├── helpers.dart
│       ├── string_utils.dart
│   ├── widgets/                 # General widgets
│       ├── app_bar.dart
│       ├── navigation_drawer.dart
├── features/                  # All features grouped by their own folders
│   ├── auth/                  # Example feature: Authentication
│   │   ├── data/              # Data layer for this feature
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_datasource_impl.dart	# Optional
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   ├── auth_local_datasource_impl.dart	# Optional
│   │   │   │   ├── auth_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   ├── repositories/
│   │   │       ├── auth_repository_impl.dart
│   │   ├── domain/            # Domain layer for this feature
│   │   │   ├── entities/
│   │   │   │   ├── user.dart
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository.dart
│   │   │   ├── usecases/
│   │       │   ├── login_usecase.dart
│   │       │   ├── register_usecase.dart
│   │   ├── presentation/      # Presentation layer for this feature
│   │       ├── cubit/
│   │       │   ├── auth_cubit.dart
│   │       │   ├── auth_state.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       ├── widgets/
│   │           ├── login_form.dart
│   │           ├── register_form.dart
│   ├── profile/               # Another example feature: Profile
│       ├── data/
│       ├── domain/
│       ├── presentation/
├── layers/                    # Optional: Shared logic across features
│   ├── shared_data/           # Common models or repositories
│   │   ├── app_repository.dart
│   │   ├── shared_models.dart
│   ├── shared_presentation/   # Common UI components or widgets
│       ├── app_drawer.dart
│       ├── app_bottom_nav.dart
├── main.dart                  # Entry point of the app
├── injection_container.dart   # Dependency injection
├── routes.dart                # Centralized routing
```

## Contributing

Contributions are welcome! Feel free to submit a pull request or report any issues.  

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
