// Will accept an array of Card objects as props
import Card from './Card';

function CardList({ cards, handleAddCard }) {
    // cards => props object
    // { cards } => props.cards
    
    return (
        <div className="card-list">
            <h2 className="component-name">CardList Component</h2>
            <br />
            {cards.map(card => {
                return (
                    <Card 
                        // key={card.id} 
                        title={card.title} 
                        content={card.content} 
                    />
                );
            })}
            <button>Add New Card</button>
        </div>
    );
}

export default CardList;