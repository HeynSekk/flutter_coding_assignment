# flutter_sample_app

A template Flutter project.

## Specs
Flutter SDK: 3.24.1
Android SDK: 35
State management: bloc
Route management: go_router
Dependency management: get_it
Networking: http
Architecture: MVVM. It has 4 components: View, Cubit/Bloc/Controller/ViewModel, Repository, Service/DataProvider.
Local storage: hydrated_bloc

## How to run the project?
- Create a Firebase project or use the existing one, put the `google-services.json` file in `android/app` dir.
- We can run the Android app by running `flutter pub get`, `flutter run`.
- Run `flutter test` or use GUI of IDEs like VS Code to run tests.
- If you changed DTO related files, go to correct dir and run `dart run build_runner build`.

## Features
- Firebase Authentication using email/password.
- Fetch the users from https://jsonplaceholder.typicode.com/users using GET method and
insert into local database.
- Retrieve and display the list of users from the database.
- User details screen for displaying individual user information.
- Upload ‘Post Model’ data to https://jsonplaceholder.typicode.com/posts using POST method.
- Function which converts the user data from database into ‘user.json’ file and save
it under Downloads folder of the mobile device.

## Limitations
- No form validation in pages like Login, Add Post. So if we entered invalid or empty data in those pages, errors will happen.
- No logging since it is optional.
- No real time reponse to user account status changes for Firebase authentication.
- No registeration feature.

## Notes
- Haven't setup or adapt the project for ios platfrom.
- If cannot test the app, please kindly use VPN.
- Most components has automated tests written. And some components do not have tests, and about two failing test cases exist. 
- Implemented the function which converts the user data from database into ‘user.json’ file and save it under Downloads folder of the mobile device.






