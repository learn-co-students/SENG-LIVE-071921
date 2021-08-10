function Header({ firstName, lastName, isLoggedIn }) {
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
    
    // RENDERING WITH TERNARY OPERATOR
    // return (
    //     <header className="header">
    //         <h2 className="component-name">Header Component</h2>
    //         <h1>Hi, {firstName} {lastName}!</h1>
    //         <p>You're { isLoggedIn ? "Logged In" : "Logged Out" }</p>
    //     </header>
    // );

    // RENDERING WITH SIMPLE CONDITIONAL LOGIC
    if (isLoggedIn) {
        return (
            <header className="header">
                <h2 className="component-name">Header Component</h2>
                <h1>Hi, {firstName} {lastName}! </h1>
                <p>You're Logged In</p>
            </header>
        );
    } else {
        return (
            <header className="header">
                <h2 className="component-name">Header Component</h2>
                <h1>Hi, {firstName} {lastName}! </h1>
                <p>You're Logged Out</p>
            </header>
        );
    }
}

export default Header;