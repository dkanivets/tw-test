## Teamwork.com test project
### Setup
To setup project simply clone repository and open **.xcworspace* file. All dependencies are commited to the repo to simplify project setup. However in real life example I would prefer to gitignore pods.

### Features

* I tried to follow *MVVM* architecture with usage of **ReactiveCocoa**
* Persistency implemented with **Realm**, however you wouldn't find any migration and cleaning methods, only adding entities is implemented in this test project.
* I've added simple tests to ensure that server responses are parsed
* There is no login, API key is simply obtained from web and pasted to *NetworService* enum

### What this app can do:

* get and show some details off all users Projects
* get and show all Task Lists for Projects
* get and show all Tasks in Task List
* create multiple tasks 

*To add multiple open Task List in which you want to add tasks and hit **+** and  specify their names in text field and hit next to specify next name. Also cells in *Add Tasks* controller have editing style so you can remove some tasks by swiping them to left and they won't be created when you hit *Submit* button. On submit app should pop to Task list and fetch tasks for that list, default sorting is from newest.*

