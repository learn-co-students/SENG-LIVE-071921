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