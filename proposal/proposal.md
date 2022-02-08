# Proposed
A shareable to do list app.

# Feature List
|Feature|Priotity (1-5)|Effort (1-5)|
|-----|-----|----|
| Design a REST API for query and save data. | 1| 1|
| Design data model for back-end database. | 1| 1|
| Implement data model for back-end database. | 2| 3|
| Implement a REST API | 2| 5|
| Design data model for in-app database.| 1| 1|
| Implement data model for in-app database.| 2| 3|
| Design a unified user interface| 1| 2|
| Design reuseable UI component| 1| 2|
| Chose ready-use library| 1| 2|
| Implement reuseable UI component| 3| 4|
| Implement reuseable other UI component| 4| 5|
| Document | 4| 2|

# General Timeline
|Date|Activity|
|----|--------|
|March 14| Respository check-in|
|March 16| Design REST API, data model for database|
|March 18| Design the user interface|
|March 20| Design the reuseable UI component|
|March 22| Do research on libraries, avoid reinventing the wheel|
|March 24| Implement the back-end|
|March 29| Implement resuable UI component|
|March 5| Implement entire user interface|
|April 14| Project due|

# Front End
- ```SQLite``` to manage in-app data.
- Maybe use some libraries to simplify the work.

# Back End
- **Framework**: ```express.js``` - Lightweight Web Framework
- **Database**: ```redis``` - Key-value Database
- **Library**: 
  - ```redis-om``` - a Redis Client Libraries

# Mock-Ups
![home page](/proposal/img/homePage.png)

![calendar page](img/calendarPage.png)

![project page](img/projectPage.png)