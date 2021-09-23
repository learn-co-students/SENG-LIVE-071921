# Phase 4 Lecture 4, Rails Serializers and Integrating React

```bash
npx create-react-app client --use-npm
```

When install completes open `client/package.json` and make 2 changes.

1. add `PORT=4000` to the beginning of the start script (so we can run our react dev server on a different port from our rails dev server)
```js
"start": "PORT=4000 react-scripts start"
```
2. add the "proxy" option at the bottom of the JSON file So we can write our fetch requests to endpoints without having to include `http://localhost:3000` every time (`fetch("/books")` instead of `fetch("http://localhost:3000/books"`)

```js
"proxy": "http://localhost:3000"
```

When you're done it should look something like this:

```json
{
  "name": "client",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "@testing-library/jest-dom": "^5.14.1",
    "@testing-library/react": "^11.2.7",
    "@testing-library/user-event": "^12.8.3",
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    "react-scripts": "4.0.3",
    "web-vitals": "^1.1.2"
  },
  "scripts": {
    "start": "PORT=4000 react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  },
  "proxy": "http://localhost:3000"
}
```

## Adding Foreman

Now that we've got a react client inside our rails app directory, we'll want to configure forman to tell ruby how to run both servers at once.

I'm not going to use foreman to run my server when I work on this project because I always want access to `byebug` and I find the logs are easier to read when the frontend and backend server processes are running in separate terminals. 

But, `foreman` relies on a `Procfile` which is a concept that will be relevant when we deploy our application later on, so I'll go through the setup now anyway.


Install foreman
```bash
bundle add foreman
```
Create the Procfile.dev
```bash
code Procfile.dev
```
Add the following lines within the file that opens:

```text
web: PORT=4000 npm start --prefix client
api: PORT=3000 rails s
```
Save the file and it'll be in the root of your rails project now.

If you don't mind running them in one terminal, you can do so with the following command:

```bash
foreman start -f Procfile.dev
```

## Some useful Client/Server Debugging content from the curriculum:

### When you see a 404 Not Found error:

- Check the Network Tab on the frontend
- Check the Rails Server logs in the backend
- Add a new route to handle the HTTP Verb + Path for this request

### When you see an Unexpected end of JSON input error:

- Check your fetch request
- Check the request in the Network tab and look at the preview tab to see what the response actually was
- Check the controller action, and make sure to render json:
- this error is usually caused by the `res.json()` line in your promise callback trying to parse something that isn't in valid JSON format.

### When you need to see data from the request in your controller:

- Add a byebug to your controller method
- Make a request from the browser
- Inspect params in the byebug session

### When you see a 500 Internal Server Error error:

- Open your Rails server log
- Look for the last request that came through
- Find the error message and stack trace to identify where the error originated

### Unexpected token < in JSON at position 0
- Open the Network tab in the devtools and look at the request. 
- This is usually caused by rails rendering an HTML response for some reason. It's usually an error page, so the preview tab in the Network dev tools will show you the rendered HTML error and you can go fix it.

## Dev/Debugging Situation

Here's what I like to do:

**4 Terminals**
1. rails server
2. npm start --prefix client
3. rails console
4. terminal in root for git/migrations/generators/etc.
5. terminal in client for running npm install without needing to add --prefix client every time.

**Postman with my endpoints programmed in–including bad inputs to test my API error handling**

**React dev server running in browser on http://localhost:4000**

I'll switch between them when I need to use them for a particular task.

## A Couple of endpoints we need to add quickly

For today, we're going to need index routes for both of our join models to support some functionality we need client side.

```rb
# config/routes.rb
  resources :user_groups, only: [:index, :create, :destroy]
  resources :user_events, only: [:index, :create, :update, :destroy]
```

```rb
# app/controllers/user_groups_controller.rb
  def index
    render json: current_user.user_groups, status: :ok
  end
```

```rb
# app/controllers/user_events_controller.rb
  def index
    render json: current_user.user_events, status: :ok
  end
```

These endpoints will be used to see which groups and which events the current user is related to from the client.

## Setup React App

In terminal for react client
```bash
npm install react-router react-router-dom react-icons --save
```
```bash
mkdir src/components
touch src/components/GroupsList.js
touch src/components/GroupDetail.js
touch src/components/GroupsContainer.js
```

In src/App.js
- Import GroupsContainer
- Add Router, NavLinks, Switch statement and Routes

```js
import './App.css';
import GroupsContainer from './components/GroupsContainer'
import { Switch, Route, NavLink, BrowserRouter as Router } from 'react-router-dom'

function App() {
  return (
    <div className="App">
      <Router>
        <NavLink to="/groups">Groups</NavLink>
        <Switch>
          <Route path="/groups">
            <GroupsContainer />
          </Route>
        </Switch>
      </Router>
    </div>
  );
}

export default App;
```

In src/App.css update the `.App` declaration to:

```css
.App {
  width: 80%;
  margin: 0 auto;
  padding-top: 2em;
}
```

In src/GroupDetail.js
- Add useEffect to fetch from /groups/:id endpoint
- display the group, it's founder, members and events

```js
import React, { useState, useEffect } from 'react'

function GroupDetail({ groupId }) {
  const [group, setGroup] = useState(null)
  
  useEffect(() => {
    fetch(`/groups/${groupId}`)
      .then(res => res.json())
      .then(group => setGroup(group))
  }, [groupId])

  if (group) {
    return (
      <div>
        <h1>{group.name}</h1>
        <h3>{group.founder ? `Founded by: ${group.founder}` : ''}</h3>
        <h2>Members</h2>
        <ul>
          {group.members?.map(member => <li>{member.username}</li>)}
        </ul>
        <h2>Events</h2>
        <ul>
          {group.events?.map((event) => <li>{event.title}</li>)}
        </ul>
      </div>
    )
  } else {
    return (
      <div>
        
      </div>
    )
  }
}

export default GroupDetail
```

In src/GroupsList.js
- accepts props:
    - groups (all the groups including the current user's membership from the api)
    - leaveGroup (a callback to send a request to DELETE '/user_groups/:id' that can take a groupId as an arg and calculate the proper user_group_id for the request)
    - joinGroup (a callback that will send a request to POST '/user_groups' with the group_id to join.)
    - createGroup (a callback that will send a request to POST '/groups' to create a new group and add it to the parent's state)
- display the list of groups including leave/join buttons depending on whether the current user has already joined the group
- add form to create new group

```js
import React, { useState } from 'react'
import { Link } from 'react-router-dom'

function GroupsList({ groups, leaveGroup, joinGroup, createGroup }) {
  const [name, setName] = useState('')
  const [location, setLocation] = useState('')

  const leaveOrJoinButton = (group) => {
    if (group.userGroup) {
      return <button onClick={() => leaveGroup(group.id)}>Leave Group</button>
    } else {
      return <button onClick={() => joinGroup(group.id)}>Join Group</button>
    }
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    createGroup({name, location})
  }
  
  return (
    <div>
      <h1>Groups</h1>
      {groups.map(group => (
        <p><Link to={`groups/${group.id}`}>{group.name}</Link> --- {leaveOrJoinButton(group)}</p>
      ))}
      <h3>Add Group</h3>
      <form onSubmit={handleSubmit}>
        <label htmlFor="name">Name </label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          name="name"
        />
        <label htmlFor="name"> Location </label>
        <input
          type="text"
          value={location}
          onChange={(e) => setLocation(e.target.value)}
          name="location"
        />
        {" "}<button type="submit">Add Group</button>
      </form>
    </div>
  )
}

export default GroupsList
```

In src/components/GroupsContainer.js
- defines routes for GroupsList and GroupDetail
- tracks `groups` and `userGroups` in state and adds useEffect calls to fetch them from the api on load.
    - `userGroups` are stored in an object with `group_id` keys so we can easily access the correct `userGroup` if it exists given the group's id that we'll already have when interacting with a group.
- defines `groupsWithMembership` that returns an array of all groups and adds the `userGroup` to all `groups` the user is a member of
- defines `leaveGroup`, `joinGroup` and `createGroup` callback which send the requests to accomplish those tasks and update the state accordingly
- passes callbacks to `GroupsList` component


```js
import React, { useState, useEffect } from 'react'
import { Switch, Route } from 'react-router-dom'
import GroupsList from './GroupsList'
import GroupDetail from './GroupDetail'

function GroupsContainer() {
  const [groups, setGroups] = useState([]);
  const [userGroups, setUserGroups] = useState({});

  useEffect(() => {
    fetch("/groups")
      .then(res => res.json())
      .then(groups => setGroups(groups))
    fetch("/user_groups")
      .then(res => res.json())
      .then(userGroups => {
        // Store the userGroups in an object with group_ids as keys.
        // We want to easily access the user's relationship with the
        // group, if we use an object, we won't need to iterate through
        // userGroups while we're traversing groups because we'll 
        // already have the group id and we can use it to access the
        // userGroup if it's there
        let userGroupsMap = userGroups.reduce((obj, userGroup) => {
          obj[userGroup.group_id] = userGroup;
          return obj;
        }, {});
        setUserGroups(userGroupsMap);
      })
  }, [])

  // map over all groups and add the associated userGroup from userGroups
  // it'll be undefined if the user isn't a member of the group
  const groupsWithMembership = () => {
    return groups.map(group => {
      return {
        ...group,
        userGroup: userGroups[group.id]
      }
    })
  }

  const leaveGroup = (groupId) => {
    let userGroupId = userGroups[groupId].id
    return fetch(`/user_groups/${userGroupId}`, {
      method: 'DELETE'
    })
      .then(res => {
        if (res.ok) {
          setUserGroups({
            ...userGroups,
            [groupId]: undefined
          })
        }
      })
  }

  const joinGroup = (groupId) => {
    return fetch('/user_groups', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        group_id: groupId
      })
    })
      .then(res => {
        if (res.ok) {
          return res.json()
        } else {
          return res.json().then(errors => Promise.reject(errors))
        }
      })
      .then(userGroup => {
        setUserGroups({
          ...userGroups,
          [groupId]: userGroup
        })
      })
  }

  const createGroup = (formData) => {
    return fetch("/groups", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formData)
    })
      .then(res => {
        if (res.ok) {
          return res.json()
        } else {
          return res.json().then(errors => Promise.reject(errors))
        }
      })
      .then(group => {
        setGroups(groups.concat(group))
      })
  }

  return (
    <div>
      <Switch>
        <Route
          exact
          path="/groups"
        >
          <GroupsList
            groups={groupsWithMembership()}
            leaveGroup={leaveGroup}
            joinGroup={joinGroup}
            createGroup={createGroup}
          />
        </Route>
        <Route
          exact
          path="/groups/:id"
          render={({ match }) => {
            return <GroupDetail groupId={match.params.id} />
          }}
        />
      </Switch>
    </div>
  )
}

export default GroupsContainer
```

### Why we need a serializer here

If we boot up our client server and our rails server and visit http://localhost:4000/groups and click on one of the groups, we'll only see the name of the group and the one event it has.

Our GroupsController's show action currently looks like this

```rb
def show
  render json: Group.find(params[:id]), include: :events
end
```
we can include members as well, but serializers give us a cleaner way to format the JSON responses we send from our API by storing the serialization logic in separate files called serializers.

To add them to our application, we'll run

```bash
bundle add active_model_serializers
```

And then,

```bash
rails g serializer Group
```

This will give us a file that starts out looking like this:

```rb
class GroupSerializer < ActiveModel::Serializer
  attributes :id
end
```

We now have to actively choose what we want to include in our API responses (instead of serializing everything to JSON by default). 
So, if we think about what will be required for our react client, we're going to need the id, name, location, events and members to come through. 

```rb
class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :location
  has_many :events
  has_many :members
end
```

If we add this and make sure we've restarted our server since we installed the new gem, we can hit the show endpoint again by visiting the GroupDetail page for our first group. When we do that we can check the rails server logs and we'll see something like this:


>[active_model_serializers] Rendered GroupSerializer with ActiveModelSerializers::Adapter::Attributes (56.69ms)
Completed 200 OK in 154ms (Views: 92.8ms | ActiveRecord: 1.1ms | Allocations: 39049)


>[active_model_serializers]   User Load (0.3ms)  SELECT "users".* FROM "users" INNER JOIN "user_groups" ON "users"."id" = "user_groups"."user_id" WHERE "user_groups"."group_id" = ?  [["group_id", 6]]
[active_model_serializers]   ↳ app/controllers/groups_controller.rb:4:in `index'
[active_model_serializers] No serializer found for resource: #<User id: 14, username: "Sam", email: "sam.boahen@flatironschool.com", bio: nil, created_at: "2021-09-22 01:40:33.245254000 +0000", updated_at: "2021-09-22 01:40:33.245254000 +0000">
[active_model_serializers]   Event Load (0.1ms)  SELECT "events".* FROM "events" WHERE "events"."group_id" = ?  [["group_id", 7]]
[active_model_serializers]   ↳ app/controllers/groups_controller.rb:4:in `index'
[active_model_serializers]   User Load (0.1ms)  SELECT "users".* FROM "users" INNER JOIN "user_groups" ON "users"."id" = "user_groups"."user_id" WHERE "user_groups"."group_id" = ?  [["group_id", 7]]
[active_model_serializers]   ↳ app/controllers/groups_controller.rb:4:in `index'
[active_model_serializers] No serializer found for resource: #<Event id: 1, title: "Rails Fundamentals", description: "first lecture in phase 4", location: "new zoom link", start_time: "2021-09-22 00:40:33.317947000 +0000", end_time: "2021-09-22 02:40:33.317976000 +0000", group_id: 6, user_id: 13, created_at: "2021-09-22 01:40:33.328492000 +0000", updated_at: "2021-09-22 17:35:09.190205000 +0000">
[active_model_serializers] No serializer found for resource: #<User id: 14, username: "Sam", email: "sam.boahen@flatironschool.com", bio: nil, created_at: "2021-09-22 01:40:33.245254000 +0000", updated_at: "2021-09-22 01:40:33.245254000 +0000">
[active_model_serializers] Rendered ActiveModel::Serializer::CollectionSerializer with ActiveModelSerializers::Adapter::Attributes (78.74ms)
Completed 200 OK in 171ms (Views: 118.9ms | ActiveRecord: 3.1ms | Allocations: 44839)

The thing to note here is that we're seeing No serializer found for resource a few times here. We see that for both Event and User currently. So, we can fix that by adding in those serializers

```bash
rails g serializer User
```

```bash
rails g serializer Event
```

```rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email
end
```

```rb
class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :location, :start_time, :end_time
end
```

Now, let's try hitting the endpoint again by refreshing the React app in the browser.

When I did this at first, I was frustrated as I wasn't seeing any changes, it turns out that leaving the `include: :events` in the controller actually leads to our serializer being ignored!

So, we need to update `groups#show`
```rb
def show
  render json: Group.find(params[:id])
end
```

And then when we try again in the browser, we should see  the group, it's members and events.

Notice, though, that if we return to the groups list page and check the devtools

The '/groups' endpoint is now also returning all the members and events for each group. This is because AMS will use the serializer matching the name of the model by default. If we want to serialize the Index and Show endpoints separately, we can use two separate serializers:

```bash
rails g serializer GroupIndex
rails g serializer GroupShow
```

```rb
class GroupIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :location
end
```

```rb
class GroupShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :location
  has_many :events
  has_many :members
end
```

And then we can use these separately within our controller actions by adding the serializer option when we do the render json:

```rb
def index
  groups = Group.all
  render json: groups, each_serializer: GroupIndexSerializer
end

def show
  render json: Group.find(params[:id]), serializer: GroupShowSerializer
end
```

## Exercise

For the reading list application, there is currently no react client, so you'll need to test the serializer in Postman. The goal will be to:
- create a `BookIndex` and `BookShow` serializer. 
- The `BookIndex` will display a list of books with just the attributes that you choose
- The `BookShow` will display the attributes and also the readers of the book
    - Advanced: try to read the [ActiveModelSerializers guides on associations](https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/general/serializers.md#associations) to figure out how you can also display the users who have actually read the book (not just added it to their reading list)