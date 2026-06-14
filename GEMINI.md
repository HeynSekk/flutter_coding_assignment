# Project Instructions: Playground Flutter

This is a Flutter-based application demonstrating MVVM architecture, Clean Architecture principles, and robust testing practices. It was originally developed as a professional coding assignment.

## Project Overview

- **Purpose**: A showcase application featuring Firebase Authentication, REST API integration (DummyJSON), local data persistence, and comprehensive testing.
- **Architecture**: MVVM with a multi-package structure.
  - **Application Layer (`lib/`)**: UI (Views), State Management (Cubits), and App-specific Logic.
  - **Repository Layer (`packages/user_repository/`)**: Abstracts data sources and provides a clean API to the app.
  - **Remote Source Layer (`packages/user_remote_source/`)**: Handles REST API communication.
- **Core Technologies**:
  - **Framework**: Flutter 3.24.1
  - **State Management**: `bloc` / `cubit` with `hydrated_bloc` for offline persistence.
  - **Routing**: `go_router`
  - **Dependency Injection**: `get_it`
  - **Networking**: `http`
  - **Code Generation**: `build_runner` with `json_serializable`

## Building and Running

### Prerequisites
- Flutter SDK (v3.24.1 or compatible)
- Firebase project setup (Requires `google-services.json` in `android/app/` and `GoogleService-Info.plist` in `ios/Runner/`).
- Enable Email/Password authentication in the Firebase Console.

### Key Commands
- **Install Dependencies**: `flutter pub get` (run in root and packages if needed).
- **Run Application**: `flutter run`
- **Run Tests**: `flutter test`
- **Code Generation**: `dart run build_runner build --delete-conflicting-outputs` (run in `lib/` or specific packages where models are defined).
- **Test Coverage**:
  ```bash
  flutter test --coverage
  genhtml coverage/lcov.info -o coverage/html
  open coverage/html/index.html
  ```

## Development Conventions

### Architecture Details
- **View**: Flutter Widgets (Stateless or Stateful).
- **Cubit/Bloc**: Handles business logic and state transitions. Injected into Views via `go_router` or constructor.
- **Repository**: Handles data orchestration between remote and local sources.
- **Service/DataProvider**: Low-level API or database clients.

### Coding Style
- Follow standard Flutter/Dart linting rules defined in `analysis_options.yaml`.
- Use `json_serializable` for all DTOs and models that require JSON conversion.
- Dependency injection is managed via `get_it` in `lib/di/service_locator.dart`.

### Testing Standards
- **Unit Tests**: Focus on Cubits, Repositories, and Utility classes.
- **Widget Tests**: Located in `test/features/` to verify UI behavior and interaction.
- **Mocks**: Use `mocktail` for creating mock objects in tests.
- **Coverage**: Aim to maintain high coverage (currently ~90%).

## Key File Locations
- `lib/main.dart`: Entry point and Firebase initialization.
- `lib/presentation/router.dart`: Centralized route management.
- `lib/di/service_locator.dart`: Dependency injection registration.
- `lib/features/`: Feature-based modular structure (login, users_list, user_detail, add_post).
- `packages/`: Contains internal library packages for repository and remote source.

