# Phase 4, Lecture 6 Authorization

Today's key concepts:
- Access Control
- `before_action` macro for condensing controller logic

## Meetup Clone Features

- Users can be admins
- Events can only be updated and deleted by an admin or their creator

## Reading List Features

- Users can be admins
- Only admins can update and delete books

## Adding Admin Functionality

```bash
rails g migration AddAdminToUsers admin:boolean
```

Generates a migration that looks like this

```rb
class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean
  end
end
```

Which we can then run:

```bash
rails db:migrate
```
And then in a `rails console` we can create a new admin user:

```rb
User.create(username: 'admin', password: 'password', email: 'admin@test.com', admin: true)
```

We're not going to update our strong parameters in the `UsersController` so users won't be able to set themselves as an admin through the API, it can only be done via the console or a SQL query currently.

## Adding Authorization

- Authentication has been added
- access control has not
- `current_user` returns whoever is logged in–if we have a logged in user. But our controller actions are calling the `current_user` method assuming that it returns a user even if nobody is currently logged in.
- test out a request in postman to demonstrate the problem.

### How do we fix this?

------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------

#### Solution

```rb
def confirm_authentication
  return render json: { error: "You must be logged in to do that." }, status: :unauthorized unless current_user
end
```

Why do we need the `return` there?

### 2 ways to use the before_action:
- add to application_controller so it defaults to applying to every api call.
    - we then have to add a skip_before_action to individual controllers/actions if we don't want this check
- add it to individual controllers.
    - we then have to add it in a bunch more places and we need to remember to add it if we need it.

#### Say we choose the first approach, where do we need to add `skip_before_action :confirm_authentication`? ... Why?

------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------
------------

### Break

## Authentication vs Authorization

In our first step, we've checked that we have a properly authenticated user before providing access to a protected route/resource. The status code we're using for this is a 401 unauthorized. 

There is actually another status code called 403 forbidden that is used to signify an authorization failure. 

| Failure | Meaning |
|---|---|
| Authentication Failure (401)| No credentials present (forgot your keycard) |
| Authorization Failure (403)| Credentials are present but don't provide access (using your keycard for the wrong room or to access an employees only area) |

Up until this point, the authorization logic we have is embedded within our controller actions. We have code like this:

```rb
def destroy
  event = current_user.created_events.find(params[:id])
  event.destroy
  # we'll render the event as json in case we want to enable undo functionality from the frontend.
  render json: event, status: :ok
end
```

We're only going to allow users who created an event to delete it, because if we try to send the request logged in as another user, the event won't even be found and we'll get a 404 response rather than a 403. If we want to have more permissive authorization logic, allowing more than one user to destroy a record, but not **all** users, then we need something a little different. 

In this section, we'll use our newly built `admin` functionality to authorize certain endpoints and allow admin users access to modify or delete other users' events without granting that access to everyone. We could apply this functionality to our other controllers as well, but in the interest of time, we're going to focus on the `EventsController` today.

Before we do this, I'm going to demonstrate a pattern you'll see a lot in rails controllers. We define a private method that runs before the `show`, `update` and `destroy` actions and finds the appropriate ActiveRecord model object.

```rb
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  # ...
  private 
  
  def set_event
    @event = Event.find(params[:id])
  end
end
```

This will allow us to remove or replace some logic in our individual controller actions (`show`, `update`, and `destroy`) that fetch an event from the database using its id. We'll also need to make sure we replace `event` with `@event`. Next, we'll add another private method for authorization.

```rb
def authorize_user
  user_can_modify = current_user.admin? || @event.user_id == current_user.id
  return render json: { error: "You don't have permission to perform that action" }, status: :forbidden unless user_can_modify
end
```

This method is only necessary before the `update` and `destroy` actions because `show` is non destructive and should be accessible to all logged in users. 

So, now that we have the private method, we'll need to add the `before_action` so it is invoked before `update` and `destroy`

```rb
before_action :set_event, only: [:show, :update, :destroy]
before_action :authorize_user, only: [:update, :destroy]
```

>NOTE the before_actions run in order, so we can access `@event` within `authorize_user` only if we add the `before_action :authorize_user` **below** `before_action :set_event`

We'll have something like this when we're finished:

```rb
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]
  
  def index
    events = Event.all.includes(:user_events)
    render json: events, each_serializer: EventIndexSerializer
  end

  def show
    render json: @event
  end

  def create
    event = current_user.created_events.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    # we'll render the event as json in case we want to enable undo functionality from the frontend.
    render json: event, status: :ok
  end

  private

  def event_params
    params.permit(:title, :description, :location, :start_time, :end_time, :group_name, :cover_image_url)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user
    user_can_modify = current_user.admin? || @event.user_id == current_user.id
    return render json: { error: "You don't have permission to perform that action" }, status: :forbidden unless user_can_modify
  end

end
```

To test it out, we can create an event belonging to the first user in the console:

```rb
User.first.created_events.create(title: 'testing', description: 'admin should be able to delete this', start_time: '2021-09-29 12:00:00', end_time: '2021-09-29 13:00:00', location: 'zoom', group: Group.last)
```
Now, boot up the servers, log in as the admin using the credentials: 
```
username: 'admin'
password: 'password'
```
Go to the events list and you should have the option to cancel the event.



# Exercise


## Authentication
If you haven't completed adding authentication to the reading list application, the steps to complete for that are below. If you have, feel free to skip ahead to the [Authorization](#Authorization) portion. 

### Dependencies (Gems/packages)
We need bcrypt so that we can store encrypted (salted and hashed) versions of our users passwords instead of storing passwords in plain text:

```bash
bundle add bcrypt
```
### Configuration (environment variables/other stuff in config folder)
We need to tell rails that we want session cookies. To do that, we'll add the following to the config block in `config/application.rb`
```rb
config.middleware.use ActionDispatch::Cookies
config.middleware.use ActionDispatch::Session::CookieStore

# Use SameSite=Strict for all cookies to help protect against CSRF
config.action_dispatch.cookies_same_site_protection = :strict
```
We'll also need to include the middleware within the `ApplicationController`

```rb
class ApplicationController < ActionController::API
  include ActionController::Cookies
  # ...
end

```
### Database
We need a `password_digest` column in our `users` table.

```bash
rails g migration AddPasswordDigestToUsers password_digest
```

```bash
rails db:migrate
```
### Models

- We need to add a uniqueness validation for username so we can consistently find the right user for authentication
- We'll add a uniqueness validation to email, but we can set `allow_blank: true` so that it's not required.
- We need to add the `has_secure_password` macro to the model to implement the `authenticate` and `password=` methods used in login & signup actions respectively
### Views/Serializers

- We'll want a `UserSerializer` that returns only the `id`, `username`, `email`, and `bio`

### Controllers

We'll need actions for:
- `users#show` - for rendering the currently logged in user as json
- `users#create` - for handling the signup form submission and rendering the newly created user as json (while logging them in)
- `sessions#create` - for handling the login form submission and rendering the newly logged in user as json
- `sessions#destroy` - for handling logout and removing the user_id from the session cookie

We'll also need to change the `current_user` method so that it makes use of the user_id stored in the session cookie sent from the browser. This will allow us to login as different users and have our application recognize user's requests by reading the user_id out of the cookie and returning the associated user.

```rb
def current_user
  @current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
end
```
### Routes

```rb
get "/me", to: "users#show"
post "/signup", to: "users#create"
post "/login", to: "sessions#create"
delete "/logout", to: "sessions#destroy"
```

## Authorization

- Create and run a migration to add an `admin` boolean column to the `users` table.
- Add a private method called `confirm_authentication` to the `ApplicationController`
    - this method should return a rendered json message saying `"you must be logged in to do that"` with a status of unauthorized unless there is a user currently logged in. (We can use the `current_user` method to confirm this)
- Add a `before_action` call to `:confirm_authentication` to the `BooksController` and `UserBooksController`
- Add a private method `set_book` to the `BooksController`
```
  def set_book
    @book = Book.find(params[:id])
  end
```

- Add a `before_action` for `:set_book` to the `BooksController` below `:confirm_authentication`
     
    run this only before the `:show, :update, :destroy` actions
- We don't currently have `update` or `destroy` defined within the `BooksController`, so add them and remove the restrictions in `config/routes.rb` ( `only: [:index, :show, :create]`)so there are routes for them as well:
```rb
def update
  if @book.update(book_params)
    render json: @book, status: :ok, serializer: BookShowSerializer
  else
    render json: book.errors, status: :unprocessable_entity
  end
end

def destroy
  @book.destroy
  head :no_content
end
```
```rb
resources :books
```
- Add a private method `authorize_user` to the `BooksController`. In it, return `true` if the currently logged in user is an admin, `false` if not.
- Add a `before_action` for `authorize_user` to the `BooksController` that runs only before `:update` and `:destroy`.
- Since we're allowing books to be destroyed now (by admins only) we need to handle the join records that may be pointing back to any existing books by adding `dependent: :destroy` after the `has_many :user_books` within the `Book` model (app/models/book.rb)
- Finally, since our frontend will show additional options to admins, we need to include the admin status in our `UserSerializer` so that the UI for updating and deleting books will be visible to admin users.