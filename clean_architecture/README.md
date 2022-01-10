# Clean Architecture
A possible solution to implement a clean architecture design using BLoC for state management

---
## Development Environment
* Flutter: Version 2.5.3 
* Laptop: Macbook M1 Pro 
* Test Device: Simulator (iPhone 13 Pro Max) running iOS 15.2

Note: I did run into some podfile issues when compiling this project on my laptop using the new M1 Pro CPU. Following
[these steps](https://github.com/CocoaPods/CocoaPods/issues/9907#issuecomment-879969967) fixed the issue for me.

If there are any other issues, please let me know.

---
## Core Concepts
* Clean Architecture Design
* BLoC (Version 7 - This app will be updated once I have updated my guide on BLoC as there are breaking changes with version 8.x)
* JSON Mapping & Model Creation (including null safety)
* Internationalization (Only English and Japanese)
* Dependency Injection (linking _logic_ to _frontend_)

---
## Project Structure
This project makes use of the BLoC logic in the same project - in actual practice, this would most likely be in
its own repository, and then we would use the pubspec.yaml to link the _logic_ section to our actual _frontend_ section. 
However, this example is more to just serve as an overall guideline of clean architecture design, so for
ease of use when browsing and making changes, I have both the BLoC & UI components in one application, split into 2
folders, namely:
1) logic
2) frontend

---
## Logic Folder
The logic folder follows the clean architecture design with BLoC as the state management solution.

Refer either to the internal PDF guides I have created, or to 
[this link](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)
for a different explanation.

Due to the simplicity of this sample app, there are some concepts that are not implemented that do not have anything directly
to do with clean architecture (such as a lifecycle manager, websocket manager, etc.)

---
## Frontend Folder
The frontend folder shows what I believe is a good structure for breaking up your widgets into the correct .dart files and folders.
With large features, this structure could result in lots of individual files & folders, but it will make it much more readable &
easy to navigate, especially for new-comers to a team, or people that have to do work on a feature they themselves did not implement.

Other than that, the actual frontend part of this application shows how to link your dependency injection, how to use translations,
how to use the [BlocBuilder, BlocListener, BlocConsumer] widgets, how to possibly display error messages, etc.

Some parts of the _frontend_ aren't fully implemented (i.e. the images for albums - they are not linked to a specific album,
but just displayed based on index - this is just to make the screen not look too bland. Ideally the albums would each have their
own coverArtUrl as a String property on the entity/model)

Note: The _Employee_ part of the app has a high failure rate when hitting the API endpoint.
This has the fortunate side effect of being able to see how error messages can be displayed to users,
but if the call does fail, just keep pressing the retry button until it succeeds.

---

Creator & Owner - [James Hertzog](https://github.com/jbhertzog).
