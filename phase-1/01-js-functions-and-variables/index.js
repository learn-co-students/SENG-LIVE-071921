// Creating Variables

// define a variable 'fahrenheit' using 'var' and set it to 90
console.log("hoisted?", fahrenheit); // returns undefined
var fahrenheit = 90;
console.log("after initialization", fahrenheit); // returns 90

// define 'fahrenheit' again using 'var' and set it to 100
var fahrenheit = 100;
console.log("redeclared", fahrenheit);

// define a variable 'fahrenheit' using 'let' and set it to 90
console.log("hoisted?", fahrenheit);
let fahrenheit = 90;
console.log("after initialization", fahrenheit);

// define 'fahrenheit' again using 'let' and set it to 100, can we?
let fahrenheit = 100;
console.log("redeclared", fahrenheit);

// define a variable 'fahrenheit' using 'const' and set it to 90
const fahrenheit = 90;

// define 'fahrenheit' again using 'const' and set it to 100, what happens?
const fahrenheit = 100;

// Defining functions

// define a function 'printTemp' using function declaration that returns 'Today's temperature is 90 degrees fahrenheit'

function printTemp() {
  return "Todays temperature is 90 degrees fahrenheit";
}
// define a function 'printTemp' using function expression that returns 'Today's temperature is 90 degrees fahrenheit'

const printTemp = function () {
  return "Todays temperature is 90 degrees fahrenheit";
};
// define a function 'printTemp' using arrow functions that returns 'Today's temperature is 90 degrees fahrenheit'

const printTemp = () => {
  return "Todays temperature is 90 degrees fahrenheit";
};

// Executing functions vs reference

printTemp; // will print a reference to the function
printTemp(); // will call function and evaluate logic

// Parameters vs Arguments

// Using the printTemp function again, let's pass in a parameter 'temperature'

function printTemp(temperature) {
  return "Today's temperature is 90 degrees";
}

// How can we use the paramater to make our code more dynamic?

function printTemp(temperature) {
  return `Today's temperature is ${temperature} degrees fahrenheit`;
}

// now invoke the function and pass in an argument

printTemp(100);

// First Class Citizens

// store a function inside of a variable

function greeting(name) {
  return `Hello everyone, I'm ${name}`;
}
const astrologist = greeting("Bob");

// pass a function as an argument

function printTemp(cb, temperature) {
  return `${cb(
    "Bob"
  )}. Today's temperature is ${temperature} degrees fahrenheit`;
}

printTemp(greeting, 90);

// functions are objects and can have properties

greeting.status = "printed";

// Scopes

// Global Scope

let globalVariable = "I am in the global scope";

// Function Scope

function whatsTheScope() {
  let functionVariable = "I am inside of a function";
}

// // Block Scope

function whatsTheScope() {
  if (true) {
    let blockVariable = "I am inside of a block";
  }
}

// Call Stack and Job Queue

function firstFunction() {
  return 
}
function secondFunction() {
  firstFunction()
}
function thirdFunction() {
  secondFunction()
}
function fourthFunction() {
  thirdFunction()
}

fourthFunction()
