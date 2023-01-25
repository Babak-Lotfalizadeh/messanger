# Messenger Introduction
An application for testing firebase ability , in this App we used almost all of firebase tools, 
fireStore, push notification, cloud_functions و firebase_auth, firebase_analytics, etc.<br />
![login in mobile](https://firebasestorage.googleapis.com/v0/b/flutter-messanger-b99a3.appspot.com/o/Screenshot_1673865508.png?alt=media&token=00aeefa5-386d-49ba-bce5-d67d128b3696)<br />
![login in web](https://firebasestorage.googleapis.com/v0/b/flutter-messanger-b99a3.appspot.com/o/Screenshot_1673865547.png?alt=media&token=90e96205-f236-4f6a-b753-4db3d4885406)<br />
![Enter password animation (rive)](https://firebasestorage.googleapis.com/v0/b/flutter-messanger-b99a3.appspot.com/o/Screenshot_1673865510.png?alt=media&token=4c54f819-a814-449d-905a-bfd5b04264a1)<br />
![Enter user name animation (rive)](https://firebasestorage.googleapis.com/v0/b/flutter-messanger-b99a3.appspot.com/o/Screenshot_1673865514.png?alt=media&token=5788c2cf-f393-443a-8808-b8891a9a8508)<br />


# Features
Register and sign in with firebase auth<br />
find already registered user, and message them<br />
Custom theme for application in setting<br />



# Getting Started:
you can download the source or fork it in android studio or any other Idea<br />  
if you don't have Flutter you need to download that so Idea can run the source code<br />
if you don't have it you need to follow this :https://docs.flutter.dev/get-started/install<br />
after that you need to create a Virtual device or connect a real device to the system and create a build or run the app on it<br />
in first step you need to create a user , we dont have any limit on it right now, we use user because we save all the information about the Kanban on the user<br />
if you have the user you can use that and login.<br />
in the first page you can see three column, To do , in progress and don<br />
for start you can create a task, and name it , this task will move to "to do section"<br />
then you can click on it to update that, add description and more<br />
then you can move that task to in progress so you can see the timer<br />
after that you can move that to don , in this case task are finish adn you can see the timer has stopped and time are recorded<br />
you can switch between board just by sweeping on mobile ,<br />
you can drag an item and move it to right side, this will let you move the task to next column, and rop it there<br />
this app support multi language, so you can change that on setting page<br />
for that you can click on navigation menu on top left side<br />
click on setting button<br />
then click on language section and select you designer language<br />
also in this page you can change the theme of application<br />
you can change drake mode or light mode on setting and also in navigation menu in home page.<br />
but if you dont do that, app going to on dark mode if your phone is on dark mode<br />

# Technical details
in this section we talk mainly about Technical details of project<br />
The application is built using the Flutter framework<br />
we used the latest version of flutter 3.3.10 and dart version of 2.18.6<br />


## Structure
Folders By Type/Domain
## State management
provider
## server / cloud
using firebase for database and sync data with

## other features
### Setting page
you can edit the colors, primary,secondary, text on this page, also you can change the app language and theme on this page too
### Multi language
you can change the app language on the setting page
### Custom Theme color, primary, secondary, text color
you can change the app theme on setting page
### dark mode/ light mode
this will be change base on the mobile / web theme , but you can change the dark mode on setting page and navigation menu too
### provider state management
the main state management for the app
### shared_preferences for local data
we save some information related to setting on local, so we used SP for that
### web / mobile design
we try to design app , so we can use on both web (large) and mobile screens
### material 2 / material 3 switch in setting
there are a switch on setting page that you can back to material 2 if you like it more
### drag Items
we add some ability to items on list / columns, so you can drag them and move to another list/ column. we use default widget and we don't used third party library for that, we simply used draggable widgets
### change page on drag items
we used page view for switch between the columns and after that we add a area and left and right side, so if any item drag to that , swith to next page or last page, so we can go next page easy , and I think this what are soo much user friendly compare to other  approach
### change page animation
we add animation to drag Items and move them and changing the page so user have smooth experience
### ability to have n columns (is static now because of multi language and no Back end)
this ability are exist to have custom column, n number of them, but for that to be working we need some kind of clound function or server api, so we can handle the language, we can add that in future if we need that