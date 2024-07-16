# Restaurant App using BLoC Pattern with Clean Architecture

This Flutter project demonstrates how to build a restaurant listing and detail app using the BLoC pattern with Clean Architecture principles. It integrates network requests using Retrofit, state management with BLoC, and various other libraries.

## Features

- View a list of restaurants.
- Search restaurants by name.
- View detailed information about each restaurant.
- Post reviews for restaurants.

## Libraries Used

- Retrofit: For making network requests to the RESTful API.
- Dio: HTTP client for Flutter, used alongside Retrofit.
- Bloc: State management library.
- Equatable: Simplifies equality comparisons for Dart objects.
- GetIt: Dependency injection for managing app-level dependencies.
- Google Fonts: For custom typography in the app.

## Project Structure

The project is structured following the Clean Architecture principles:

- **data**: Contains data sources, repositories, and models.
- **domain**: Defines business logic and use cases.
- **features**: Contains UI components organized by features.
  - **detail_restaurant**: Handles detailed restaurant views and interactions.
  - **restaurants_list**: Manages the restaurant list display.
  - **search_restaurants**: Implements search functionality for restaurants.

## Getting Started

To run the project locally, follow these steps:

1. Clone this repository.
   ```bash
   git clone https://github.com/DeepSyyy/restaurant_app_bloc_clean_architecture.git
   ```
2. Install depedencies using Flutter.
   ```bash
   flutter pub get
   ```
3. Ensure you have an Android emulator or iOS simulator running.
4. Run the app.
   ```bash
   flutter run
   ```

## Retroift Configuration

Retrofit is configured to work with Dio for making API calls. Here's how it's set up:

- **lib/data/data_source/remote/restaurant_api_service.dart**: Retrofit service interface definition.
- **lib/data/data_source/remote/restaurant_list_api_service.dart**: Retrofit service implementation using Dio.
- **lib/data/repository/restaurant_repository_impl.dart**: Repository implementation using Retrofit services.

For more details on Retrofit usage, refer to the [Retrofit documentation](https://pub.dev/packages/retrofit)
