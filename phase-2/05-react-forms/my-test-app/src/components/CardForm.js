// What hook will we need to use?
import { useState } from 'react';

function CardForm({ handleAddCard, cards }){
    // What state will we use to manage ImgURL input value?
    // const [ imgUrl, imgUrlSetter ] = useState("");
    // const [ title, imgUrlSetter ] = useState("");

    // Create a state (formData) to manage all of our
    // controlled inputs
    const [ formData, formDataSetter ] = useState({
        title: "",
        content: ""
    });

    // Create a callback function to manage the onChange behavior for each of our controlled inputs
    // function manageImgUrl(event) {
    //     imgUrlSetter(event.target.value);
    // }

    function manageFormData(event) {
        let myName = event.target.name;
        let myValue = event.target.value;

        // formData = { firstName: "Louis", lastName: "Medina" }
        // ...formData => { firstName: "Louis", lastName: "Medina" }

        formDataSetter({
            ...formData,
            [myName]: myValue
            // [imgUrl]: "My imgUrl"
        });
    }

    // Capture all submitted data and store into a separate state (submittedData)
    // const [ submittedData, submittedDataSetter ] = useState([]);

    // Create a callback function to handle onSubmit behavior for our controlled form
    function handleSubmit(event) {
        // console.log("handleSubmit fired");

        // Prevent default form submission behavior
        event.preventDefault();

        // Capture submitted data (that we want)
        const newCard = { 
            id:  parseInt(cards[cards.length - 1].id) + 1,
            title: formData.title, 
            content: formData.content
        };

        // Merge submitted data with existing form submissions
        // submittedData => []
        // [...submittedData, newFormData]

        handleAddCard(newCard);

        // Clear out input values upon form submission
        formDataSetter({
            ...formData,
            title: "",
            content: ""
        });
    }

    // Return a bit of JSX that will contain our painting Title and imgUrl
    // const formSubmissions = submittedData.map((data, index) => {
    //     return (
    //         <div key={index + 1}>
    //             <p>Title: {data.title}</p>
    //             <p>imgUrl: {data.imgUrl}</p>
    //             <hr />
    //         </div>
    //     )
    // }); 

    return (
        <div>
            <h1> Add a New Card</h1>
            {/* Breakout Activity #1: Add Necessary Attributes to Make Remaining <input>s Controlled */}
            {/* Extra Credit: How can we avoid using separate callback functions to handle each controlled <input>? */}
            {/* Hint: Create a new state (formData) and "name" for each input to distinguish them from one another. */}
            <form onSubmit={handleSubmit}>
                <input 
                    type="text" 
                    placeholder="Title" 
                    value={formData.title} 
                    onChange={manageFormData}
                    name="title"
                    className="input"
                />
                <input 
                    type="text" 
                    placeholder="Content" 
                    value={formData.content} 
                    onChange={manageFormData}
                    name="content"
                    className="input"
                />

                <input 
                    type="submit" 
                    value="Submit"
                    className="input"
                />
            </form>
            
            {/* Breakout Activity #2: Dynamically display a list of Added Titles / Artists as we continue to submit new Painting entries. */}
            {/* Hint: Create a state called "submittedData" to store all submittedData. Map over this state
            to create <div>s for each new Painting submission */}
            {/* {formSubmissions} */}
        </div>
    );
}

export default CardForm;
