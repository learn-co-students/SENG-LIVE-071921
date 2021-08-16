// useState Hook Import
import { useState } from 'react';

// Import CSS Styles
import './App.css';

// Component Imports
import Header from './components/Header';
import NavBar from './components/NavBar';
import CardList from './components/CardList';
import CardForm from './components/CardForm';

// Import Array of Card objects
import cardData from './cards';

function App() {

  // Q: Why do we want to manage 'cards' state here?
  
  // A: Changes that we make to the 'cards' state will
  //    persist to other components further down the
  //    component hierarchy. We have 'lifted' the cards
  //    state to a suitable / scalable position in the
  //    component hierarchy.

  // Set "cards" state + setter function
  const [ cards, setCards ] = useState(cardData);
  
  // Passed as a prop (handleAddCard) to <CardList />
  function handleAddCard(newCard) {
    
    // Avoid direct state mutation by using the Spread Operator
    const newCardsArray = [...cards, newCard]
    
    // Whenever we are updating state via Functional Components, it's necessary
    // that we pass a new object/array to "setState." Otherwise, it won't trigger
    // a re-render.
    // https://jkettmann.com/how-to-accidentally-mutate-state-and-why-not-to#hold-on-were-in-2020-what-about-functional-components
    setCards(newCardsArray)
  }
  
  return (
    <div className="App">
      {/* NavBar Component */}
      <NavBar isLoggedIn/>
      
      {/* Header Component */}
      <Header 
        firstName="Louis" 
        lastName="Medina" 
      />

      <CardForm 
        handleAddCard={handleAddCard}
        cards={cards}
      />

      {/* CardList Component */}
      <CardList 
        cards={cards} 
      />
    </div>
  );
}

export default App;
