# Flutter Coding Assignment

This project is a coding assignment I did for a company. It passed the test and I got the job offer.

This project demonstrates:
- how to use MVVM architecture and Bloc pattern
- how to do Dependency Management
- how to manage route
- how to architect the project for testability
- how to write unit and widget tests
- how to do REST API calls using `http` package

Essentially how to architect a nice Flutter project which is clean enough to reduce cognitive load in coding, maintainable, extendable and testable.

## Features
- Firebase Authentication using email/password.
- Fetch the users from https://jsonplaceholder.typicode.com/users using GET method and
insert into local database.
- Retrieve and display the list of users from the database.
- User details screen for displaying individual user information.
- Upload ‘Post Model’ data to https://jsonplaceholder.typicode.com/posts using POST method.
- Function which converts the user data from database into ‘user.json’ file and save
it under Downloads folder of the mobile device.

## Using the project
This project could be useful for those who want to learn concepts like automated testing, dependency injection, a maintainable Flutter project architecture in a practical application since it demonstrates those concepts.

Even you can use it as a template project when you get to work on a coding assignment when you apply for a job.

This kind of showcase projects are really useful when we want to apply concepts we learned into a practical project.

In the future, I would add demonstrations for responsive design, design system, error handling, etc as well.


## Specs
- Flutter SDK: 3.24.1,
- Android SDK: 35,
- State management: bloc,
- Route management: go_router,
- Dependency management: get_it,
- Networking: http,
- Architecture: MVVM. It has 4 components: View, Cubit/Bloc/Controller/ViewModel, Repository, Service/DataProvider,
- Local storage: hydrated_bloc,

## How to run the project?
Since it use Firebase auth, you need a Firebase project and connect this project to it. Follow these steps to add Firebase https://firebase.google.com/docs/flutter/setup?platform=android . Enable email/password Authentication at Firebase console, create a sample account for testing.

- We can run the app by running `flutter pub get`, `flutter run`.
- Run `flutter test` or use GUI of IDEs like VS Code to run tests.
- If you changed DTO related files, go to correct dir and run `dart run build_runner build --delete-conflicting-outputs`.

### See test coverage
Run:
- `flutter test --coverage`
- `genhtml coverage/lcov.info -o coverage/html`
- `open coverage/html/index.html`

Ref:
https://stackoverflow.com/questions/50789578/how-can-the-code-coverage-data-from-flutter-tests-be-displayed/53663093#53663093

## Limitations
- No form validation in pages like Login, Add Post. So if we entered invalid or empty data in those pages, errors will happen.
- No logging
- No real time reponse to user account status changes for Firebase authentication.
- No registeration feature.

## Notes
- If cannot test the app, please kindly use VPN.
- Most components has automated tests written. And some components do not have tests.






