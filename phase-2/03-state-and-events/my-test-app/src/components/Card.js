import { useState } from 'react';
import Button from './Button';

function Card({ title, content="Add Some Content Here"}) {
    // States
    // const [ VARIABLE NAME OF STATE, SETTER FUNCTION ] = useState(DEFAULT VALUE OF STATE)

    // Create a state to keep track of whether Card has been added to Cart
    // const [ isAdded, setAdded ] = useState(false); 

    // Create a state to keep track of Likes
    // const [ isLiked, setLiked ] = useState(false); 

    // Create a State to handle Card info visibility
    const [ isVisible, setVisibility ] = useState(true);

    const ColoredLine = ({ color }) => (
        <hr
            style={{
                color: color,
                backgroundColor: color,
                height: 2,
                width: "10rem"
            }}
        />
    );

    // Abstract out Card Details into JS Function returning JSX
    function showCardDetails() {
        return (
            <>
                <h2 className="component-name">Card Component</h2>
                <h1>{title}</h1>
                <ColoredLine color="black" />
                <p>{content}</p>
            </>
        )
    }

    // Create a Callback Function to contain setVisiblity 
    function toggleVisibility() {
      setVisibility(isVisible => !isVisible);
    }

    return (
        <div className="card">
            {/* TERNARY OPERATOR */}
            {/* CONDITION ? IF TRUE : IF FALSE */}

            {/* { isAdded ? <h2>Added to Cart</h2> : showCardDetails } */}

            {/* Break Out Activity #2: Create a <Button /> Component to enable each Button to 
            manage its own isToggled state. 💡 To configure each <Button />, try passing a 
            “name” prop from Card.js */}

            { isVisible ? showCardDetails() : <h2>Added to Cart</h2>  }

            <Button name="cart" toggleVisibility={toggleVisibility} />
            <br />
            <Button name="like"/>

            {/* Break Out Activity #1: Modify the onClick behavior of our Add to Cart <button> 
            to render only an H2 element saying “Added to Cart” in place of Card details. */}

            {/* <button className="button" onClick={() => setAdded(!isAdded)}>
                { isAdded ? "Remove From Cart" : "Add To Cart" }
            </button>
            <br />
            <button className="button" onClick={() => setLiked(!isLiked)}>
                { isLiked ? "❤️" : "♡" }
            </button> */}
        </div>
    );
}

export default Card;