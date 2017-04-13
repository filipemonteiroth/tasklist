## Task List
	
	This is a simple task list project built with Rails 4 and Angular 1.

### Running project

* Getting started
  
  After clone, run on root folder ```bundle install```
  
* Database

  Run and create the database
  
    ```rake db:create```
  
    ```rake db:migrate```
    
    ```rake db:seed``` - For initial data
  
* Running

  Run ```rails s``` on the root folder and then open: https://localhost:3000
  
* Login

  Login with email: ```john@mail.com``` password: ```12345678```
  
* Tests

  Run ```rspec``` on the root folder
  
  Check the code coverage on `coverage/index.html`

### Endpoints

The JSON requests provides the following endpoints:

#### - GET /tasks.json

List of all tasks, with tasks assigned to current user and other tasks. e.g:

```{my_taks: [{tasks}], other_tasks: [{tasks}]}```

#### - POST /tasks.json

Creates a task

##### parameters:

* **title:** the title of the task
* **description** the task description

#### - PUT/PATCH /tasks/:id.json

Updates the task by the given `id`

##### parameters:

* **title:** the title of the task
* **description** the task description

#### - PUT /tasks/:id/assign_to_me.json

Assign the task by the given `id` to the current logged user

#### - PUT /tasks/:id/complete.json

Completes the task by the given `id`

#### - DELETE /tasks/:id.json

Deletes the task by the given `id`

### Gem set

There's the list of the most important gems used on this project:

* sqlite - Simple database, simple project :)
* devise - For a fast and simple login
* rspec - One of the best gems for unit and integration tests
* timecop - You know, you got to freeze the `Time` sometimes :)
* simplecov - Code coverage
* factory girl - Build models on tests
