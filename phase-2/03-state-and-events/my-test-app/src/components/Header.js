function Header({ firstName, lastName }) {
    // props = JS Object
    
    // PULL VALUE VIA KEY REFERENCE 
    // let props = { firstName: "Louis", lastName: "Medina" }
    // x.firstName => "Louis"
    // x.lastName => "Medina"

    // PULL VALUE VIA DESTRUCTURING
    // let props = { firstName: "Louis", lastName: "Medina" }
    // const { firstName, lastName } = props
    // firstName => "Louis"
    // lastName => "Medina"
    
    return (
        <header className="header">
            <h2 className="component-name">Header Component</h2>
            <h1>Hi, {firstName} {lastName}! 👋</h1>
        </header>
    );
}

export default Header;