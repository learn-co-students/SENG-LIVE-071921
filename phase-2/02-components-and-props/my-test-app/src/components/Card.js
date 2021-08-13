// Accepts a Card object as a prop

function Card({ title, content="Default Value"}) {
    // props = { title: "My Title" }
    // props.title => "My Title"
    
    return (
        <div className="card">
            <h2 className="component-name">Card Component</h2>
            <h1>Title: {title}</h1>
            <p>Content: {content}</p>
        </div>
    );
}

export default Card;