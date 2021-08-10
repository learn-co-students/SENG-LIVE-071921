import logo from './logo.svg';
import './App.css';

// Component Imports
import Header from './components/Header';
import NavBar from './components/NavBar';
import CardList from './components/CardList';

// Data
import cards from './cards';

function App() {
  return (
    <div className="App">
      {/* NavBar Component */}
      <NavBar />
      
      {/* Header Component */}
      <Header 
        firstName="Louis" 
        lastName="Medina" 
        isLoggedIn
      />

      {/* CardList Component */}
      <CardList cards={cards} />
    </div>
  );
}

export default App;
