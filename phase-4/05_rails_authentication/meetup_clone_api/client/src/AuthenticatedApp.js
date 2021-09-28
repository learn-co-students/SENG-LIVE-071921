import './App.css';
import GroupsContainer from './components/GroupsContainer'
import EventsContainer from './components/EventsContainer'
import { Switch, Route, NavLink, useHistory } from 'react-router-dom'

function AuthenticatedApp({ currentUser, setCurrentUser }) {
  const history = useHistory()
  
  const handleLogout = () => {
    fetch(`/logout`, {
      method: 'DELETE',
      credentials: 'include'
    })
      .then(res => {
        if (res.ok) {
          setCurrentUser(null)
          history.push('/')
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
      </Switch>
    </div>
  );
}

export default AuthenticatedApp;
