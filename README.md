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
|-- |-- core
|   |   |-- common
|   |   |   |-- views
|   |   |   |   |-- page_under_construction.dart
|   |   |-- res
|   |   |   |-- colors.dart
|   |   |   |-- fonts.dart
|   |   |   |-- media_res.dart
|   |   |-- services
|   |   |   |-- router.dart
|   |-- main.dart
|-- test
|-- web
|-- pubspec.yaml
```

## Clean Architecture
The project is structured in the concept of three layers. Domain, Data and Presentation layer.

## Domain Layer
We have here three sub directories:
 - entities
 - repositories
 - usecases

### Entities
Represent the core data model of the application. They define the structure and properties of the data. Each entity class is a blueprint of the object that is passing around the application. Entety answers the question what kind of the data we are using in the application.

### Repositories
Define the contract between the data layer and the domain layer. This is done in the form of the interface. In dart we don't have interfaces like in Java but here we mimic it with abstract class.

### Usecases
Represents the business logic of the application. They depend on the repository and call its methods to perform data operations. Usecases enforce SRP (Single responsibility principle) and focus on specific functionalities.

## Licences
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)