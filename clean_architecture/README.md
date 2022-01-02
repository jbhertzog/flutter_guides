# Clean Architecture
A possible solution to implement a clean architecture design using BLoC

### What this sample app does:
* Makes an API Call to retrieve some dummy data about some employees
* Parses the result to a JSON model that we create
* Sends the results back to our BLoC, which then gets used by the UI

### Core Concepts:
* Clean Architecture Design
* BLoC
* JSON Mapping & Model Creation (including null safety)

Note: This project makes use of the BLoC logic in the same project - in actual practice, this would most likely be in
its own repository, and then we would use dependency injection / a service locator to link the _logic package_ to our
actual app(s). However, this example is more to just serve as an overall guideline of clean architecture design, so for
ease of use when browsing and making changes, I have both the BLoC & UI components in one application, split into 2
folders, namely:
1) logic
2) frontend

Creator & Owner - [James Hertzog](https://github.com/jbhertzog).
