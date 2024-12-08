Contents at a glance)
Add post,
Authentication
Data,
Generate JSON,
Offline behavior,
User list,
Widget tests,


Actual contents)
### Authentication
First time, the user is logged out, and must show login page.
If logged in, must show user list page.

Login page)
Tap Login, Show loading while calling api.
Tap Login, Show failure if any failure. (invalid crenditial, other err)
Tap login, must get to User List if auth was succeeded.
Tap login, if no internet, must alert user.
If auth check fail, must ask them to manual login.

Logout)
Tap Logout, must logout the user and must show Login page. When open the app again, must show Login page.


### Add post
- no internet, add post, must alert the user.
x //- add post fail, must alert the user, and allow retry.
- add post succeed, must alert the user, and Upload button must change to Ok button.
- must show Loading cirlce while calling the api.

### Data
- no internet, and first time, must show "no internet"
- no internet, and first time, show "no internet", when tap Retry, must retry and if get internet, must show data.
- no internet, not the first time, must show data from local db.
- has internet, must show data from remote source.

### Generate JSON,
When success, must alert, and user.json file must be saved in Downloads dir.
When fail, must alert.

### Offline behavior
Offline, logged in: show users list.
Offline, logged out: show Login page.

### User list
- no internet, must alert, user connect internet and retry, must show the list

### Widget tests
User List page)
//Must show loading while loading.
//Must show data correctly when get data.
//Must show Cannot fetch user when fail.
//Must show No internet when no internet.
//Must show Add Post dialog when tap Upload floating button.
//Must use a scrollable,
x//When No internet or Failure, must retry if tap Retry button.

User info card)
//Must show user data correctly

User details page)
//Must show user info for id, name and website correctly.

Add post)
//When tap Upload button, must call addPost function of the cubit.
//Initially, must show 3 text fields and Upload button.
//Must show loading while loading.
//Must show success when success.
//Must close dialog when tap Ok button in success state.
//Must show Cannot fetch user when fail.
//Must show No internet when tap Upload button and no internet.

