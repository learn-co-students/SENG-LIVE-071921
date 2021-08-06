# JavaScript Functions and Variables

## Goals:
- Understanding variables:
    - What are variables?
    - How to define variables
    - When to use var, let, and const
    - How to identify the scope of a variable
- Functions dive deep: 
    - What are functions?
    - Different ways to define a function
    - Function reference vs execution
    - What are high order functions?
    - "First class citizens"
    - Parameters vs arguments
- Call stack and job queue:
    - What is a call stack/job queue?
    - importance in javascript*
- Debugging:
    - How to read errors 
    - How to use debugger
    - How to use console.log


## Variables
- Allows us to store and label values


#### Defining Variables

- `var`: 
    - Can optionally initialize with a value
    - Side effects: not block scoped, can be redeclared, hoisting
    - Not used in modern scripts
- `let`:
    - Can optionally initialize with a value
    - Block scoped
    - Can not be redeclared
    - Used now in place of var
- `const`:
    - Must be initialized with a value
    - Block scoped
    - Can not be redeclared

#### Variable Scope

- Can exist in 3 different scopes: 
    - global scope:
        - Anything defined outside of a function
    - function scope
        - Variable declared inside of a function
    - block scope was introduced in ES6
        - Variable defined inside of a block
        - A block is anything with opening and closing curly braces ``` if () {} ```

## Functions

- The building blocks of JavaScript applications
- Functions are objects
- Allow us to organize behaviors into reusable pieces

#### Ways to define a function: 

```
Function declaration: we use the keyword `function`

    function helloWorld() {
        // logic
    }

```

```
Function expression: stored inside a variable, defined as an anonymous function

    const helloWorld = function() {
        // logic
    }

```

```
Arrow functions: shorter syntax 

    const helloWorld = () => 'Hello World'

    // if return statement is more than 1 line

    const helloWorld = () => {
        let statement = "Hello World"
        return statement
    }

```

#### Function Reference vs Execution

- Function reference is a copy of the function. Returned if function is not invoked
- Function execution is when the function is invoked 

```
    function helloWorld(){
        return 'Hello World'
    }

    helloWorld // returns a function reference 
    helloWorld() // returns 'Hello World'
```

#### Parameters vs Arguments
- Parameter is defined in function declaration as a placeholder for the value that will be passed in during execution
```
    function sayName(name){
        // do something with name
    }

    // name is a parameter. It acts as a placeholder for a name value to be passed in
    
```
- Argument is a value that is passed to function during execution
```
   sayName("Bob")

   // 'Bob' is an argument. It is the value replacing the placeholder 'name'

```

#### High Order Functions
- A function that takes in a function as an argument or returns a function

#### First Class Citizens
- Functions are first class citizens
- What this means is:
    - We can store them as variables
    - Use them in arrays
    - Assign them as object properties (methods)
    - Pass them as arguments
    - eReturn them from other functions

#### Callstack
- Importance:
    - Fundamental to how js works
    - Can help with debugging
- What is a callstack?
    - A hierarchy and order of operations for function calls
    - Like a 'to-do' list
- How does it work? 
    - JavaScript is single threaded, meaning one thing happens at a time(synchronous)
    - Last In, First Out (LIFO)
    - When a function is called it is added to the top of the stack
    - Once the function is returned, it will be ‘popped’ off the stack
- ‘Maximum call stack size exceeded’ error (recursion?)

#### Resources
- [The Old Var](https://javascript.info/var)
- [MDN Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions)
- [The Ultimate Guide to JavaScript Variables](https://www.javascripttutorial.net/javascript-variables/)