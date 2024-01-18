# UAFC MOBILE APP
## this is a church mobile app using flutter and firebase.

### the app is basically a virtual church where users will be able to perform the bellow attions:
1. Read church feeds/news
2. Read church notifications/announcements
3. See upcoming church events.
4. Read the bible
5. Locate local church branches near you.
6. interact with the church: request prayers, offer to server, inqire about services etc.
7. See/Read about the foundations the church is running
8. Stream current and previous sermons.
9. Sunday school interactive videos
10. Pay tithe/offer
11. Find out more about the church and the ministires.

<hr>


to test and run the project you will need to install [Flutter](https://docs.flutter.dev/get-started/install) and/or [android studio](developer.android.com/studio/install) it is not compulsory to download android studio alternatively 
you can use one of the bellow methods:
> to test with your mobile device you need to enable enable [android developer options](developer.android.com/studio/debug/dev-options)
> test with web (the view will be streched you might want to adjust you browser accordingly).\
> get a different emulator other than android.
### All the workable file are located in the LIB folder\
folder structure under lib:
- **components** : this folder contains all resuable the shared componets used throughout the app.
- **dto** : this folder has all the dummy data and how the data is structured, in each data we also have firestore db call for the actuall data.
- **screens**: screens contains all the screens on the app, due to the complexity of the app other screens are within the root screens.
- **services**: this are the DB service calls we have for auth, reads and writes.

  ## SCREENS:
  - **HOMESCREEN**
    * homescreen is the landing screen after login and it has subscreens
      1. Feeds: this is the church news/feeds. the feeds are stored from firestore and they use a shared componet, when a feed is clicked a new subscreen will popout with information about the feed. Admin have the delete previlage
      2. Journey: this is a step by step guide for every church to help a new memeber and/or an already existing with their faith journey.  journery has multiple sub screens based on the cutegory of the journey selected. Admin have the delete previlage
    * eventScreen is a sub screen of the homescreen and it contains all the upcoming church events\
    * ministryscrreen is a sub screen of the homescreen and it contains the bellow sub screens:
      1. BibleScreen: the bible
      2. Minitries: Each and every church has different minitries with different leaders ranging from:
           1. Kids ministry/ sunday school
           2. mens ministry
           3. wemens ministry
           4. youth ministry
    * LocationScreen is a sub screen of the homescreen and it is located on the top right tab: the screen contains information about the nearest local branches\
    * NotificationScreen is a sub screen of the homescreen and it is located of the top right tab: the screen contains notifications/announcements from the church
  - **CHATSCREEN**
    * ChatScreen is the screen where users can chat to the leaders of the church requesting prayer, offering to serve, enquiring about church related mattersm requesting assistance from the church etc.
  - **STREAMSCREEN**
    * Streamingscreen is for streaming current and previous sermons. streaming from youtube
  - **DONATESCREEN**
    * donatescreen is a tithe/donation and offering payment screen
  - **MORESCREEN**
    * morescreen contains user specific function sub screen:
      1. profilescreen: profile screen display information of the logged in user. user can also update their details : name, surname, phone number, gender etc.
      2. foundationscreen: this are all the foundations the church has. admin has the delete previlage
      3. technicalscreen: this is a technical support screen where the user can send/report any issue experrienced on the app
      4. privacypolicyscreen: this is the screen about the privacy policy regulations
      5. touacreen: this is a term of use screen stating the terms of using the app
      6. adminScreen: the admin screen gives the admin the ability to write/add information to the app ranging from: feeds, notifications, events, minitry information, streams etc
  - **AUTHENTICATIONSCREENS**
    * loginscreen: the landing screen after the splash screen, login has two types of logins:
      1. login_page: login screen  this hangles login with username and password
      2. googlelogin is hangled by loginScreen
    * registrationscreen: for registering a new user
  - **OTHERSCREENS**
    * screens: barrel file\
    * splashscreen: first displayed screen, splach screen with the church logo\
    * mainapp: the bottomnav\
    * main: this file contains all the named routes of the app
