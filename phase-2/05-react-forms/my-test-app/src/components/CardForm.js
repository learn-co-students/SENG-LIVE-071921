// Breakout Activity #1: Add Necessary Attributes to Make Remaining <input>s Controlled
    // Extra Credit: How can we avoid using separate callback functions to handle each controlled <input>?
    // Hint: Create a "name" for each input to distinguish them from one another. */

// Breakout Activity #2: Dynamically display a list of Added Cards as we continue to submit new Card entries.

// What hook will we need to use to manage states for CardForm?
import { useState } from 'react';

function CardForm({ handleAddCard, cards }){
    // Create states we will use to handle title and content
    // const [ title, titleSetter ] = useState("");
    // const [ content, contentSetter ] = useState("");

    // Create callback functions to manage the onChange behavior for each of our controlled inputs
    // function manageTitle(event) {
    //     titleSetter(event.target.value);
    // }

    // function manageContent(event) {
    //     contentSetter(event.target.value);    
    // }

    // Extra Credit: Create a state (formData) to manage all of our form data
    const [ formData, formDataSetter ] = useState({
        title: "",
        content: ""   
    })

    // Extra Credit: Create ONE callback function to manage the onChange behavior for any of our
    // controlled inputs

    function manageFormData(event) {
        // Capture name and value from target of event
        let targetName = event.target.name;
        let targetValue = event.target.value;

        // Update formData state with new form submission data
        formDataSetter({
            // Object we want to modify
            ...formData,
            
            // Key / value pairing to be updated
            [targetName]: targetValue 
        });
    }

    // Create a callback function to handle onSubmit behavior for our controlled form
    function handleSubmit(event) {
        let newId = parseInt(cards[cards.length - 1].id) + 1;
        // let newId = cards.length + 1;

        // Prevent default form submission behavior
        event.preventDefault();

        // Create newCard JS object with formData and generate
        // a unique ID for each new object
        const newCard = {
            id: newId,
            title: formData.title,
            content: formData.content
            // ...formData
        }

        // Use handleAddCard from props to add the newCard JS object
        // to the existing array of Card objects (cards)
        handleAddCard(newCard); 

        // Clear out input values upon form submission using formDataSetter
        formDataSetter({
            // key / value pairs to update
            title: "",
            content: ""    
        });
    }

    return (
        <div>
            <h1> Add New Card</h1>
            <form onSubmit={handleSubmit}>
                <input 
                    type="text" 
                    placeholder="Title" 
                    name="title"
                    className="input"
                    onChange={manageFormData}
                    value={formData.title}
                />
                <input 
                    type="text" 
                    placeholder="Content" 
                    name="content"
                    className="input"
                    onChange={manageFormData}
                    value={formData.content}
                />

                <input 
                    type="submit" 
                    value="Submit"
                    className="input"
                />
            </form>

            <p>{formData.title} {formData.content}</p>
        </div>
    );
}

export default CardForm;