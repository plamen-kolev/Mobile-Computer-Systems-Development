12.02.2017 09:00-12:00
Brainstorm on app ideas and features

13.02.2017 14:00-19:00
Initialised the basic skeleton of the code with dependencies and environment

05.03.2017 15:00-16:00
Wireframes for storyboard

13.03.2017 17:00-21:00
Fontboard creation
Font picking
Arrangement
Print production work

14.03.2017 8:00-11:00
Write-up on user stories

18.03.2017 13:10 - 15:00
Write-up on user stories

18.03.2017
16:00 - 17:00
Started writing buisness case

19.03.2017  11:00 - 11:30
finished buisness case
12:00 - 17:00
Moodboard

17:00 - 22:00
Working on the backend, created pending friendships, removed add friend if pending or self

20.03.2017 06:30 - 13:00
Learn angularjs2

13:00
Gave up implementing it in angular and research into backend sollutions

14:00
Use mailboxer ruby gem for messaging and web sockets for notification

23.03.2017
16:00 - 17:00
Finished the users stories and business case write-up

17:30-18:20
Exported photoshop files into pdfs. Got ready the materials for the deadline submission

24.03.2017
17:30 - 20:00
Integration of the mailerbox module for messaging between two people.
Going through it's api and following a youtube tutorial to learn the basics

20:00 - 20:30
The basic integration is done and it is time to build more "fancy features"

25.03.2017
06:30 - 8:30
Mailboxer does not provide realtime chat features, decided to go with integrating an api solution.
Twillio has a beta programmable chat, spent 2 hours integrating it into the app.
Will spend more to yank mailboxer completely.
Have to implement the logic for creating a conversation
Also making the scope of the conversation private

9:30 - 11:00
Integrated messaging scopes, still getting javascript errors during onload events
Upnext, working on creating the message read properties. Currently finishing the tests with multiple users communicating with each other

15:00 - 18:00
Working on creating a way to indicate a reading point for each user, every message up to that will be considered as "message ignored"
Building a javascript call to keep track of channel read status and adding a backend method for updating the up-to messages index.

18:30 - 19:30
Worked on styling the chatbox so it does not look horrible

21:00 - 22:19
Playing with css styling

26.03.2017
07:30 - 09:30
Played with the styling of the send button.
Integrated drop.js into the emoji buttons to open the emoji panels.
Backend and frontend emogi display

12:00 - 15:00
Added callbacks when emojis are clicked to register send events, made it possible to send emjoi messages
Added the karma system, but nothing happens yet

27.03.2017
7:00-9:00
Removed dropjs as it was causing dom issues.
Replaced it with own module to toggle chat emoticons.
Also moved the horrible mess of javascript I wrote to reusable modular chunks and functions.

Moved most of the rendering logic to backend rails calls, js does a post request

10:00 - 12:00

The ignore feature has been added now,
Added api call that deletes a message on the back end, it also gets called

Next up - update rude emoticons when karma is gained or used
Fix bug with inserting emoticons
Notify upon karma gain
Implement search functionality

Experimenting with nodejs angular and sockets io - 10:00 - 13:00


 
 During the period 26 to 3 august, built a simple angular shopping website with the p  urpose of becoming better at front end javascript development. This was not only for   the coursework, but also for personal development
 
13:00 - 15:00

03 May. 2017

Created small webserver in express that uses socket.io, which subscribes to messaging rooms and sends chatroom messages to clients

18:00 - 19:00 
Added front-end component to message passing. Now will integrate jwt token authentication to the back-end to ensure only athorised users can view messages. Using devise and jwt and knock

Added auth service to angular, login screen and route guard to the chat section

19:00 
Started working on scavenging the old interface and migrating it to the new one - the style actually looked very reasonable

19:49
Due to issues with the old environment and twillio keys being deleted from old operating system, spend lots of time trying to troubleshoot the issue and inserting wrong api keys.

Found the keys and moving forward with cloning the look and feel

04 May 2017
22:00 00:00

Will integrate that with devise https://www.sitepoint.com/introduction-to-using-jwt-in-rails/

The solution is very unstable, skipping

Found advanced rest tool, made everything so simple.

Now chat messages display properly in the chat box, next step is to create messages database entry and store messages persistently

05 May 2017
06:38 - 08:44 
Now will be testing the api for doing post requests for messages, in the mean time will be doing validation for adding someone as a friend and being the correct user
Created automated scripts that populate the database with fake friendships with fake messages

08:44 - 09:28

Will be integrating the new messaging api to the frontend, will be writing send message function.
Trying to force chat box to be same height as user's screen

Angular does not let me do things simply as jquery, after hours of struggling, hardcoding the chat window size

09:40 - 10:33

Will be working on send message feature - workflow:  frontend sends a message to express, express notifies the user to check for new message with the database
Managed to force each message to be vieable only by the authenticated users that are in the message's chatroom

Carrying on to frontend message api call

11:17 - 12:00
Implemented send message feature with response and persistence

Removed sending a socket message if message comes from self - this improves performance by appending messages sent from self to the local message array

12:01 - 13:00

Working on notifying the user upon new message, this message is fetched via a web request - this is done for security reasons to prevent users from reading unauthenticated messages

13:50

Inserting emoticons, wrote a page that retuns packend information about emoticons and their associated weight. Rude emoticons have karma cost and weight, default emoticons have weight of 0

14:33 - 15:33
Begin inserting emoticons to the frontend via the backend api

17:21 - 19:11

Working on creating the karma system on the back end
Karma display has been done.

Spend long period of time on trying to embed images (emoticons) in input fields, stumbled upon https://github.com/froala/angular2-froala-wysiwyg, will be integrating that next. At this point, icons are viewable (a list of available icons), but they cannot be sent or embeded into the input box.

20:00 - 20:42

After struggling to integrate any wysiwyg editors that have any minimal intefaces, decided to use an emoji library and store emoji codes, then render emojis on the client side

20:42 - 21:21
Spend time decoding emoji unicode into image elements, but angular 2 treats them as inline strings. Meaning emojis cannot be rendered from api call directly onto the page

Will be using rails module to serve pre-rendered emojis to the browser

https://codereview.stackexchange.com/questions/20126/regex-to-get-all-image-links < used this for regexp

12:51 - 14:13

Working on the front end to reduce karma when rude emoticons are used, also to disable emoticons visually upon lack of karma

Had fun parsing unicode, emoji code and image urls

15:00 - 15:38
Finished two way binding when karma updates, emojis now hide approperiately

15:38 - 16:35
Discovered that it is very difficult to serve emoticons, because prerendered body images do not display properly, trying to figure out if that is due to front end or back end issues

Discovered that angular 2 does html escape by default, fixed it that by using their documentation and a lot of googling and stack overflow browsing.

16:35
Will dockerise the solution for practice, must also create 

16.49

Crating angular 2 environment variables for production and development setup
