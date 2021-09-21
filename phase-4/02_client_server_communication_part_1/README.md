# Phase 4, Lecture 2 - Client Server Communication part 1

Today's focus:

- building out `create` actions in our controllers
- validating user input
- using strong parameters to specify the allowed parameters for post/patch requests
- returning appropriate status codes

## Meetup Clone features list

- Users must provide a unique name when creating a group
- Users must provide a :name, :location, :description, :start_time, :end_time when creating an event
- Users can RSVP to events
- Users can join other groups

## Users must provide a unique name when creating a group

### Request
POST '/groups'
```js
fetch(`http://localhost:3000/groups`,{
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({name: 'Online Software Engineering 071921'})
})
```
### Route

```rb
resources :groups, only: [:create]
# or
post '/groups', to: 'groups#create'
```

### Controller

```rb
class GroupsController < ApplicationController
  # ...
  def create 
    group = Group.create(group_params)
    render json: group
  end

  # ...

  private 

  def group_params
    params.permit(:name, :location)
  end
end
```

### Model

```rb
class Group < ApplicationRecord
  # ...
  validates :name, presence: true, uniqueness: true
end
```

### Response

We want our API to check if we've successfully created a group or if some validation error prevented the save. To do this, we'll need to add some conditional logic to the create action:

```rb
class GroupsController < ApplicationController
  # ...
  def create 
    group = Group.new(group_params)
    if group.save
      render json: group, status: :created # 201 status code
    else
      render json: group.errors, status: :unprocessable_entity # 422 status code
    end
  end

  # ...

  private 

  def group_params
    params.permit(:name, :location)
  end
end
```

The status code in the response allows us to indicate to the frontend whether or not the request was a success. The way that we interact with the status code from our client side code is by working with the [response object](https://developer.mozilla.org/en-US/docs/Web/API/Response) that fetch returns a [promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) for.

#### Example

Fetch returns a promise for a response object. The first callback that we pass to `then` to consume that resolved promise value takes that response object as an argument. That response object has a status code and a body that we can read from.  When we do `response.json()` in the promise callback, we're parsing the body of the response from JSON string format to the data structure that it represents. The response object also has an `ok` property that indicates that the status code is between 200-299

```js
fetch('http://localhost:3000/groups', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  }, 
  body: JSON.stringify({name: "Online Software Engineering 071921"})
})
  .then(response => {
    if(response.ok) {
      return response.json()
    } else {
      return Promise.reject(response.json())
    }
  })
  .then(events => {
    console.log(events) // happens if response was ok
  })
  .catch(errors => {
    console.error(errors) // happens if response was not ok
  })
```

If the response status is not in the 200-299 range, then ok will be false, so we'll want to return a rejected Promise for the response body parsed as json. We can then attach a catch callback to handle adding an error to state after it's caught by the catch callback.

## Users must provide a :name, :location, :description, :start_time, :end_time when creating an event

### Request
POST '/events'
```js
fetch('http://localhost:3000/events',{
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    title: 'Rails Client/Server Communication part 1',
    description: 'Validations, strong parameters, mass assignment, status codes and the create action',
    location: 'online',
    start_time: "2021-09-21T11:00:00",
    end_time: "2021-09-21T13:00:00",
    group_id: 1
  })
})
```

### Route

```rb
resources :events, only: [:create]
# or
post '/events', to: 'events#create'
```

### Controller

```rb
class EventsController < ApplicationController
  # ...
  def create 
    event = Event.create(event_params)
    render json: event
  end

  # ...

  private 

  def event_params
    params.permit(:title, :description, :location, :start_time, :end_time, :group_id)
  end
end
```

### Model

```rb
class Event < ApplicationRecord
  # ... 
  validates :title, :description, :location, :start_time, :end_time, presence: true
  validates :title, uniqueness: { scope: [:location, :start_time]}
end
```

### Response

We want our API to check if we've successfully created an event or if some validation error prevented the save. To do this, we'll need to add some conditional logic to the create action:

```rb
class EventsController < ApplicationController
  # ...
  def create 
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created # 201 status code
    else
      render json: event.errors, status: :unprocessable_entity # 422 status code
    end
  end

  # ...

  private 

  def event_params
    params.permit(:title, :description, :location, :start_time, :end_time, :group_id)
  end
end
```

```js
fetch('http://localhost:3000/events',{
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    title: 'Rails Client/Server Communication part 1',
    description: 'Validations, strong parameters, mass assignment, status codes and the create action',
    location: 'online',
    start_time: "2021-09-21T11:00:00",
    end_time: "2021-09-21T13:00:00",
    group_id: 1
  })
})
  .then(response => {
    if(response.ok) {
      return response.json()
    } else {
      return Promise.reject(response.json())
    }
  })
  .then(events => {
    console.log(events) // if response was ok
  })
  .catch(errors => {
    console.error(errors) // if response was not ok
  })
```

## Users can RSVP to events

### Request

```js
fetch('http://localhost:3000/user_events', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    event_id: 1
  })
})
```

### Route

```rb
resources :user_events, only: [:create]
# or 
post '/user_events', to: 'user_events#create'
```

### Controller

For this functionality, users will only be able to add themselves to an event at the moment, so our API will need a way of knowing which user is making the request. Next week, we'll learn about how to do this for real, but for now, we're going to add a method called `current_user` to our application controller that just returns one of the users we created within the `db/seeds.rb` file. 

If we need to simulate being logged in as another user, we can update the `current_user` method to return the user we want to switch to. We'll replace this method later, but for now it will help us to build out functionality on the server that requires knowledge of the currently logged in user without actually having authentication set up yet.

```rb
class ApplicationController < ActionController::Base
  # ...

  private

  def current_user
    User.first
  end
end
```

Then, within the other controller, we'll use the current_user method to build the associated object.

```rb
class UserEventsController < ApplicationController
  # ...
  def create
    user_event = current_user.user_events.create(user_event_params)
    render json: user_event
  end

  # ...
  private

  def user_event_params
    params.permit(:event_id)
  end
end
```
### Model
We want to ensure that we aren't creating multiple user events for the same combination of user and event as that would serve no purpose here.
```rb
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :event_id, uniqueness: { scope: :user_id }
end
```

### Response

We want our API to check if we've successfully created an event or if some validation error prevented the save. To do this, we'll need to add some conditional logic to the create action:

```rb
class UserEventsController < ApplicationController
  # ...
  def create
    user_event = current_user.user_events.create(user_event_params)
    if user_event.save
      render json: user_event, status: :created # 201 status code
    else 
      render json: user_event.errors, status: :unprocessable_entity # 422 status code
    end 
  end

  # ...
  private

  def user_event_params
    params.permit(:event_id)
  end
end
```

```js
fetch('http://localhost:3000/user_events',{
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    group_id: 1
  })
})
  .then(response => {
    if(response.ok) {
      return response.json()
    } else {
      return Promise.reject(response.json())
    }
  })
  .then(events => {
    console.log(events) // if response was ok
  })
  .catch(errors => {
    console.error(errors) // if response was not ok
  })
```


## Users can join other groups

### Request

```js
fetch('http://localhost:3000/user_groups', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    group_id: 1
  })
})
```

### Route

```rb
resources :user_groups, only: [:create]
# or 
post '/user_groups', to: 'user_groups#create'
```

### Controller

```rb
class UserGroupsController < ApplicationController
  # ...
  def create
    user_group = current_user.user_groups.create(user_group_params)
    render json: user_group
  end

  # ...
  private

  def user_group_params
    params.permit(:group_id)
  end
end
```
### Model
We want to ensure that we aren't creating multiple user groups for the same combination of user and group as that would serve no purpose here.
```rb
class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group_id, uniqueness: { scope: :user_id }
end
```

### Response

We want our API to check if we've successfully created an event or if some validation error prevented the save. To do this, we'll need to add some conditional logic to the create action:

```rb
class UserGroupsController < ApplicationController
  # ...
  def create
    user_group = current_user.user_groups.create(user_group_params)
    if user_group.save
      render json: user_group, status: :created # 201 status code
    else 
      render json: user_group.errors, status: :unprocessable_entity # 422 status code
    end 
  end

  # ...
  private

  def user_group_params
    params.permit(:group_id)
  end
end
```

```js
fetch('http://localhost:3000/user_groups',{
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    group_id: 1
  })
})
  .then(response => {
    if(response.ok) {
      return response.json()
    } else {
      return Promise.reject(response.json())
    }
  })
  .then(user_group => {
    console.log(user_group) // if response was ok
  })
  .catch(errors => {
    console.error(errors) // if response was not ok
  })
```

## Reading List Application Features