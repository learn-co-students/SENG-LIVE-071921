import './App.css';

// Component Imports
import Header from './components/Header';
import NavBar from './components/NavBar';
import CardList from './components/CardList';

// Data
import cardData from './cards';

function App() {
  return (
    <div className="App">
      {/* NavBar Component */}
      <NavBar isLoggedIn/>
      
      {/* Header Component */}
      <Header 
        firstName="Louis" 
        lastName="Medina" 
      />

      {/* CardList Component */}
      <CardList 
        cards={cardData} 
      />
    </div>
  );
}

export default App;
