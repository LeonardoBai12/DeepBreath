# DeepBreath

DeepBreath is a Flutter app for exploring air quality monitoring stations around the world, powered by the [OpenAQ API v3](https://docs.openaq.org/).

## Features

- Browse countries and their air quality monitoring stations
- View station details: owner, provider, instrument, timezone, coordinates, and active period
- See which pollutants each station monitors (PM2.5, NO₂, O₃, CO, SO₂, and more)
- Tap any sensor chip to load its latest measurement value on demand
- Search and filter countries and stations by name
- Shared element (Hero) animations between screens

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.5.0
- An [OpenAQ API key](https://docs.openaq.org/docs/getting-started)

### Setup

1. Clone the repository and install dependencies:
   ```bash
   flutter pub get
   ```

2. Create the secrets file (gitignored):
   ```bash
   cp lib/utils/api_secrets.dart.example lib/utils/api_secrets.dart
   ```
   Then replace the placeholder with your OpenAQ API key.

3. Run the app:
   ```bash
   flutter run
   ```

## Tech Stack

| Library | Purpose |
|---|---|
| [get](https://pub.dev/packages/get) | State management, DI, and navigation |
| [http](https://pub.dev/packages/http) | REST API calls |
| [flag](https://pub.dev/packages/flag) | Country flag widgets |
| [geolocator](https://pub.dev/packages/geolocator) | Device geolocation |
| [intl](https://pub.dev/packages/intl) | Date formatting |

## Architecture

Clean Architecture organized into two feature modules (`countries`, `location`), each with its own `data`, `domain`, and `presentation` layers. GetX handles dependency injection via `Binding` classes and named route navigation. Controllers are stateless — they expose `Stream<Resource<T>>` methods that screens consume with `await for`.

## Demo

Watch a walkthrough on [YouTube](https://www.youtube.com/watch?v=ahIWxjms8Ts) (PT-BR).
