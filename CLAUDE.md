# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**DeepBreath** is a Flutter app that measures air quality by location using the [OpenAQ API](https://openaq.org/).

## Commands

```bash
flutter pub get       # Install dependencies
flutter run           # Run on connected device/emulator
flutter analyze       # Lint (flutter_lints)
flutter test          # Run tests
flutter build apk     # Android release build
flutter build ios     # iOS release build
flutter test test/widget_test.dart  # Run a single test file
```

## Architecture

Clean Architecture organized into self-contained feature modules. Two features: **countries** and **location**.

Each feature follows the same internal structure:

```
lib/<feature>/
├── di/           # GetX Binding (wires dependencies via Get.lazyPut)
├── data/
│   ├── remote/   # HTTP calls + JSON parsing (Response DTOs)
│   └── repository/  # Repository implementation
├── domain/
│   ├── model/    # Domain models
│   ├── repository/  # Abstract repository interface
│   └── use_case/ # One use case per operation
└── presentation/
    ├── controller/  # GetxController (stateless — exposes Stream methods)
    └── screen/      # StatefulWidget that consumes streams
```

Shared utilities live in `lib/utils/`:
- `resource.dart` — `Resource<T>` sealed class (`Success`, `Error`, `Loading`)
- `theme.dart` — centralized colors, paddings, text styles
- `constants.dart` — API base URLs (v2 and v3 of OpenAQ)

## Key Patterns

**State management**: GetX. Controllers extend `GetxController` but do **not** hold reactive state — instead, controller methods return `Stream<Resource<T>>`. Screens are `StatefulWidget`s that consume these streams with `await for` in `initState`, then call `setState()`.

**Dependency injection**: Each feature has a `Binding` class (e.g., `CountriesBinding`) tied to its route. All deps are registered with `Get.lazyPut()` in the chain: `RemoteDataSource → RepositoryImpl → UseCases → Controller`.

**Routing**: Named routes configured in `main.dart` via `GetPage`. Routes: `/countries_screen` (initial), `/location_screen`, `/location_details_screen`. Arguments passed via `Get.arguments` map.

**Error handling**: All repository calls catch exceptions and return `Stream<Resource.Error>` with a message string. No typed exception hierarchy.

**HTTP**: Uses the native `http` package (not Dio). Responses are UTF-8 decoded for international characters.

**Search/filtering**: Done client-side in the presentation layer — data is fetched fresh each time with no caching layer.
