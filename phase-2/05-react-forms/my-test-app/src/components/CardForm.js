// Breakout Activity #1: Add Necessary Attributes to Make Remaining <input>s Controlled
    // Extra Credit: How can we avoid using separate callback functions to handle each controlled <input>?
    // Hint: Create a "name" for each input to distinguish them from one another. */

// Breakout Activity #2: Dynamically display a list of Added Cards as we continue to submit new Card entries.

// What hook will we need to use to manage states for CardForm?

function CardForm({ handleAddCard, cards }){
    // Create states we will use to handle title and content

    // Create a state (formData) to manage all of our form data

    // Create callback functions to manage the onChange behavior for each of our controlled inputs
    
    // function manageTitle(event) {
    //     
    // }

    // function manageContent(event) {
    //     
    // }

    // Create ONE callback function to manage the onChange behavior for any of our
    // controlled inputs

    function manageFormData(event) {
        // Capture name and value from target of event

        // Update formData state with new form submission data
    }

    // Create a callback function to handle onSubmit behavior for our controlled form
    function handleSubmit(event) {
        // console.log("handleSubmit fired");

        // Prevent default form submission behavior

        // Create newCard JS object with formData and generate
        // a unique ID for each new object

        // Use handleAddCard from props to add the newCard JS object
        // to the existing array of Card objects (cards)

        // Clear out input values upon form submission using formDataSetter
    }

    return (
        <div>
            <h1> Add New Card</h1>
            <form onSubmit={null}>
                <input 
                    type="text" 
                    placeholder="Title" 
                    name="title"
                    className="input"
                />
                <input 
                    type="text" 
                    placeholder="Content" 
                    name="content"
                    className="input"
                />

                <input 
                    type="submit" 
                    value="Submit"
                    className="input"
                />
            </form>
        </div>
    );
}

export default CardForm;
