# Adding Authentication

A note about today's structure.
- We'll be adding auth to the Meetup clone in part 1. The react client has been updated, if you're coding along and want to run it alongside the backend as we update it, clone down the [meetup clone client repo](https://github.com/DakotaLMartinez/meetup_clone_client). If you'd like a more detailed discussion of all the changes I made since we last met, I've got [another HackMD](https://hackmd.io/@dlm/phase4-lecture-5-071921) with a full write up that you can check out.
- When we get to the exercise, you can clone down the [reading list client repo](https://github.com/DakotaLMartinez/reading_list_client) to test it out.
- Key Authentication Concepts for the day:
    - Sessions
    - Cookies
    - Password Security
## Backend Support for Auth
The 4 requests we need here to support auth are:

| Endpoint | Purpose | params |
|---|---|---|
| get '/me' | returns the currently logged in user or 401 unauthorized if none exists. Used to determine whether to load the `AuthenticatedApp` or `UnauthenticatedApp` | none |
| post '/login' | returns the newly logged in user | username and password |
| post '/signup' | returns the newly created (and logged in) user | username, password, and password_confirmation |
| delete '/logout' | removes the user_id from the session cookie | none |

## Sessions, Cookies and the Hotel Keycard analogy

- book a reservation -> signup for account
- check in at front desk -> login to account
- key card -> cookie
- card reader -> session

## Client side changes

The overall philosophy here will be to create two components at the top level. One for logged in users and one for non-logged in users. This will allow us to reduce complexity on the frontend by making it clear on the client side when we have a logged in user and when we don't.

Here's what I've done since we last met to support authentication with react:

- Rename the `App` component to `AuthenticatedApp`, remove the Router tag
- Create an `UnauthenticatedApp` with a switch statement to render routes for the Login and Signup components.
- Create a new `App` component that has a useEffect to check if there is a logged in user. 
    - if there is, render the `AuthenticatedApp` component
    - if there isn't render the `UnauthenticatedApp` component
    - Add a router tag wrapping the conditional render so both components can redirect.
- Create a `Login` component that will be shown to non-logged in users displaying a Log In form
- Create a `Signup` component that will be shown to non-logged in users displaying a Sign Up form.
- add a Logout link to the `AuthenticatedApp` component so we can login as another user to test things out.
- After we've set up these components, the next step is to go through all of the fetches we're triggering from the `AuthenticatedApp` and its children and add the `credentials: 'include'` option to all `fetch` requests. This will ensure that the cookies issued by our rails api are included in the requests sent back to the server. This is necessary so that the current_user method can read the user_id out of the session cookie using the session method.

### client/src/App.js

```js
import React, { useState, useEffect } from 'react'
import AuthenticatedApp from './AuthenticatedApp'
import UnauthenticatedApp from './UnauthenticatedApp'
import { BrowserRouter as Router } from 'react-router-dom'

function App() {
  const [currentUser, setCurrentUser] = useState(null)
  const [authChecked, setAuthChecked] = useState(false)

  useEffect(() => {
    fetch('/me', {
      credentials: 'include'
    })
      .then(res => {
        if (res.ok) {
          res.json().then((user) => {
            setCurrentUser(user)
            setAuthChecked(true)
          })
        } else {
          setAuthChecked(true)
        }
      })
  }, [])

  if(!authChecked) { return <div></div>}
  return (
    <Router>
      {currentUser ? (
          <AuthenticatedApp
            setCurrentUser={setCurrentUser}
            currentUser={currentUser}
          />
        ) : (
          <UnauthenticatedApp
            setCurrentUser={setCurrentUser}
          />
        )
      }
    </Router>
  )
}

export default App
```


### client/src/AuthenticatedApp.js

```js
import './App.css';
import GroupsContainer from './components/GroupsContainer'
import EventsContainer from './components/EventsContainer'
import { Switch, Route, Redirect, NavLink } from 'react-router-dom'

function AuthenticatedApp({ currentUser, setCurrentUser }) {
  const handleLogout = () => {
    fetch(`/logout`, {
      method: 'DELETE'
    })
      .then(res => {
        if (res.ok) {
          setCurrentUser(null)
        }
      })
  }
  return (
    <div className="App">
      <nav>
        <span>
          <NavLink to="/groups">Groups</NavLink>{" - "}
          <NavLink to="/events">Events</NavLink>
        </span>
        <span>Logged in as {currentUser.username} <button onClick={handleLogout}>Logout</button></span>
      </nav>
      <Switch>
        <Route path="/groups">
          <GroupsContainer />
        </Route>
        <Route path="/events">
          <EventsContainer />
        </Route>
        <Redirect to="/groups" />
      </Switch>
    </div>
  );
}

export default AuthenticatedApp;
```

### client/src/UnauthenticatedApp.js

```js
import React from 'react'
import { Switch, Route, Redirect } from 'react-router-dom'
import Login from './components/Login'
import Signup from './components/Signup'

function UnauthenticatedApp({ setCurrentUser }) {
  return (
    <Switch>
      <Route exact path="/">
        <Login setCurrentUser={setCurrentUser} />
      </Route>
      <Route exact path="/signup">
        <Signup setCurrentUser={setCurrentUser}/>
      </Route>
      <Redirect to="/" />
    </Switch>
  )
}

export default UnauthenticatedApp
```


### client/src/components/Login.js
```js
import React, { useState } from 'react'
import { Redirect, useHistory, Link } from 'react-router-dom'

function Login({ setCurrentUser }) {
  const history = useHistory()
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  
  const handleSubmit = (event) => {
    event.preventDefault()
    fetch('/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({username, password})
    })
      .then(res => {
        if (res.ok) {
          res.json().then(user => {
            setCurrentUser(user)
            history.push('/groups')
          })
        } else {
          setCurrentUser({ username: "Dakota" })
          history.push('/groups')
          res.json().then(errors => {
            console.error(errors)
          })
        }
      })
  }
  return (
    <div className="authForm">
      <Redirect to="/" />
      <form onSubmit={handleSubmit}>
        <h1>Log In</h1>
        <p>
          <label 
            htmlFor="username"
          >
            Username
          </label>
          <input
            type="text"
            name="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </p>
        <p>
          <label 
            htmlFor="password"
          >
            Password
          </label>
          <input
            type="password"
            name=""
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </p>
        <p><button type="submit">Log In</button></p>
        <p>-- or --</p>
        <p><Link to="/signup">Sign Up</Link></p>
      </form>
    </div>
  )
}

export default Login
```

### client/src/components/Signup.js

```js
import React, { useState } from 'react'
import { useHistory, Link } from 'react-router-dom'

function Signup({ setCurrentUser }) {
  const history = useHistory()
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [passwordConfirmation, setPasswordConfirmation] = useState('')
  
  const handleSubmit = (event) => {
    event.preventDefault()
    fetch('/signup', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        username,
        password,
        password_confirmation: passwordConfirmation
      })
    })
      .then(res => {
        if (res.ok) {
          res.json().then(user => {
            setCurrentUser(user)
            history.push('/groups')
          })
        } else {
          res.json().then(errors => {
            console.error(errors)
          })
        }
      })
  }
  return (
    <div className="authForm">
      <form onSubmit={handleSubmit}>
        <h1>Sign Up</h1>
        <p>
          <label 
            htmlFor="username"
          >
            Username
          </label>
          <input
            type="text"
            name="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </p>
        <p>
          <label 
            htmlFor="password"
          >
            Password
          </label>
          <input
            type="password"
            name=""
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </p>
        <p>
          <label 
            htmlFor="password_confirmation"
          >
            Password Confirmation
          </label>
          <input
            type="password_confirmation"
            name="password_confirmation"
            value={passwordConfirmation}
            onChange={(e) => setPasswordConfirmation(e.target.value)}
          />
        </p>
        <p><button type="submit">Sign Up</button></p>
        <p>-- or --</p>
        <p><Link to="/">Log In</Link></p>
      </form>
    </div>
  )
}

export default Signup
```

## Backend Support for Auth
Again, the 4 requests we need here to support auth are:

| Endpoint | Purpose | params |
|---|---|---|
| get '/me' | returns the currently logged in user or 401 unauthorized if none exists. Used to determine whether to load the `AuthenticatedApp` or `UnauthenticatedApp` | none |
| post '/login' | returns the newly logged in user | username and password |
| post '/signup' | returns the newly created (and logged in) user | username, password, and password_confirmation |
| delete '/logout' | removes the user_id from the session cookie | none |


## Dependencies (Gems/packages)
We need bcrypt so that we can store encrypted (salted and hashed) versions of our users passwords instead of storing passwords in plain text:

```bash
bundle add bcrypt
```
## Configuration (environment variables/other stuff in config folder)
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
## Database
We need a `password_digest` column in our `users` table.

```bash
rails g migration AddPasswordDigestToUsers password_digest
```

```bash
rails db:migrate
```
## Models

- We need to add a uniqueness validation for username (and email) So we can consistently find the right user for authentication
- We need to add the `has_secure_password` macro to the model to implement the `authenticate` and `password=` methods used in login & signup actions respectively
## Views/Serializers

- We'll want a `UserSerializer` that returns only the `id`, `username`, and `email`

## Controllers

We'll need actions for:
- `users#show` - for rendering the currently logged in user as json
- `users#create` - for handling the signup form submission and rendering the newly created user as json (while logging them in)
- `sessions#create` - for handling the login form submission and rendering the newly logged in user as json
- `sessions#destroy` - for handling logout and removing the user_id from the session cookie

We'll also need to change the `current_user` method so that it makes use of the user_id stored in the session cookie sent from the browser. This will allow us to login as different users and have our application recognize user's requests by reading the user_id out of the cookie and returning the associated user.
## Routes

```rb
get "/me", to: "users#show"
post "/signup", to: "users#create"
post "/login", to: "sessions#create"
delete "/logout", to: "sessions#destroy"
```
