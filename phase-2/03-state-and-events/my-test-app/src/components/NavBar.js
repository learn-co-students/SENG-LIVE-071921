function NavBar({ isLoggedIn }) {
    // RENDERING WITH TERNARY OPERATOR
    return (
        <nav className="nav">
            <h2 className="component-name">NavBar Component</h2>
            <p>You're { isLoggedIn ? "Logged In" : "Logged Out" }</p>
        </nav>
    );

    // RENDERING WITH SIMPLE CONDITIONAL LOGIC
    // if (isLoggedIn) {
    //     return (
    //         <nav className="nav">
    //             <h2 className="component-name">NavBar Component</h2>
    //             <p>You're Logged In</p>
    //         </nav>
    //     );
    // } else {
    //     return (
    //         <nav className="nav">
    //             <h2 className="component-name">NavBar Component</h2>
    //             <p>You're Logged Out</p>
    //         </nav>
    //     );
    // }
}

export default NavBar;