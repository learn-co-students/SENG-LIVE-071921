// Break Out Activity #2: Create a <Button /> Component to enable each Button to 
// manage its own isToggled state. 💡 To configure each <Button />, try passing a 
// “name” prop from Card.js

import { useState } from 'react';

function Button({ name, toggleVisibility }) {

    // Create ONE state that will keep track of whether
    // a Button has been toggled, "isToggled"
    const [ isToggled, setToggled ] = useState(false);

    function toggleButton() {

        // Change value of "isToggled" State without
        // mutating original state.
        setToggled(isToggled => !isToggled);

        // If "toggleVisibility" is passed as a prop,
        // invoke the function to toggle the "isVisible"
        // state in Card.js 
        if (toggleVisibility) { toggleVisibility() };
    }

    return (
        // <>...</> is shorthand for <React.Fragment></React.Fragment>
        <>
            {name === "cart" ? (
                <button className="button" onClick={toggleButton}>
                    { isToggled ? "Remove From Cart" : "Add to Cart" }
                </button>
            ) : (
                <button className="button" onClick={toggleButton}>
                    { isToggled ? '❤️' : '♡' }
                </button>
            )}
        </>
    )    
    
    // Rendering conditional logic outside of return statement

    // if (props.name === "cart") {
    //     return (
    //         <button onClick={() => setToggle(!isToggled)}>
    //             { isToggled ? "Remove From Cart" : "Add to Cart" }
    //         </button>
    //     );
    // } else {
    //     return (
    //         <button onClick={() => setToggle(!isToggled)}>
    //             { isToggled ? '❤️' : '♡' }
    //         </button>
    //     );
    // }
}

export default Button;