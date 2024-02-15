# Flutter Dashboard App (TDD & Clean Architecture)

This Flutter Dashboard App is built with a focus on Test-Driven Development (TDD) and Clean Architecture principles. The project is structured to maintain a scalable and maintainable codebase, making it easier to manage and evolve over time.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [File Structure](#file-structure)
- [TDD Approach](#tdd-approach)
- [Clean Architecture](#clean-architecture)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Features

- Interactive dashboard with real-time data visualization.
- Clean separation of concerns following Clean Architecture.
- TDD approach for robust and reliable code.
- Cross-platform support (iOS, Android, Web).
- Modern UI/UX design.

## Getting Started

To run this project, clone the repository and execute the following commands in the project directory:

```bash
flutter pub get
flutter run
```

## File structure
The project directory structure is described in the following way.
```plaintext
|-- android
|-- assets
|-- ios
|-- lib
|   |-- core
|   |   |-- common
|   |   |   |-- views
|   |   |   |   |-- page_under_construction.dart
|   |   |-- errors
|   |   |   |-- exceptions.dart
|   |   |   |-- failures.dart
|   |   |-- res
|   |   |   |-- colors.dart
|   |   |   |-- fonts.dart
|   |   |   |-- media_res.dart
|   |   |-- services
|   |   |   |-- router.dart
|   |   |-- usecases
|   |   |   |-- usecases.dart
|   |   |-- utils
|   |   |   |-- typedefs.dart
|   |-- src
|   |   |-- on_boarding
|   |   |   |-- domain
|   |   |   |   |-- repos
|   |   |   |   |   |-- on_boarding_repo.dart
|   |   |   |   |-- usecases
|   |   |   |   |   |-- cache_first_timer.dart
|   |   |   |   |   |-- check_if_user_is_first_timer.dart
|   |   |   |-- presentation
|   |   |   |   |-- on_boarding_screen.dart
|   |-- main.dart
|-- test
|   |-- src
|   |   |-- on_boarding
|   |   |   |-- domain
|   |   |   |   |-- usecases
|   |   |   |   |   |-- cache_first_timer_test.dart
|   |   |   |   |   |-- check_if_user_is_first_timer_test.dart
|   |   |   |   |   |-- on_boarding_repo.mock.dart
|-- web
|-- pubspec.yaml
```

## Clean Architecture
The project is structured in the concept of three layers. Domain, Data and Presentation layer.

### Errors
`exceptions.dart`, the file contains custom exceptions that application can throw. And Exception in Dart is a type of error that represents a program failure that can be caught and handled within the application. Exceptions include additional information like a message and a status code, is useful for debugging and error handling.

- `ServerException`: Represents an error that occurs during network communication with server.
- `CacheException`: Represents an error related to local data storage, such as when reading from or writing to a local database or cache.

### Failures
`failures.dart`, the file defines Failure classes which are used to represent domain-level errors. They can be used to encapsulate details about cache or server-related issues, respectively.


- `Failure` An abstract class that provides a base for specific types of failures.
- `CacheFailure` Specific types of failure that inherit from Failure.
- `ServerFailure` is a subclass of Failure, and it includes a named constructor called fromException.

```
try {
  // Some code that might throw a ServerException
} catch (e) {
  if (e is ServerException) {
    throw ServerFailure.fromException(e);
  }
}
```

## Domain Layer
The domain layer in the context of Clean Architecture, is responsible for encapsulating the core business logic and rules of the application. This layer is highly reusable and testable. It contains only definitions. Domain layer does not depend on any framework it is pure. It only depends on the language which can be any language that is picked.

We have here three sub directories:
 - entities
 - repositories
 - usecases

### Entities
Represent the core data model of the application. They define the structure and properties of the data. Each entity class is a blueprint of the object that is passing around the application. Entety answers the question what kind of the data we are using in the application.


### Repositories
Define the contract between the data layer and the domain layer. This is done in the form of the interface. In dart we don't have interfaces like in Java but here we mimic it with abstract class.
`abstract` class is a class that can't be instantiated and often contains abstract methods. This are methods without implementation. We use abstract classes to define a common interface that other classe must implement.

### Usecases
Represents the business logic of the application. They depend on the repository and call its methods to perform data operations. Usecases enforce SRP (Single responsibility principle) and focus on specific functionalities.

## Data Layer
Explains how data in the app are handled. Extends the functionality of domain layer.

# Presentation Layer
Handle UI when we talking to the server. There we use bloc or other state managment solution.

### Testing

## Licences
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)