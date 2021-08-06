// Arrays
// What are arrays?

let friends = [];
let friends = new Array();
let friends = new Array('Rachel')

// we can add items to an array, what is the technical term for these individual items
let friends = ["Ross", "Monica", "Joey"];

// Counting items in an array

friends.length 

// Accessing Elements

let ross = friends[0];
let joey = friends[friends.length - 1];

// Manipulate arrays
// point out that we can add/remove elements

// adding to an array
friends.push("Rachel"); // will add rachel to the end of the array
friends.unshift("Phoebe"); // will add Pheobe to beginning of the array

// removing elements from an array
friends.pop(); // removes last element and returns that element
friends.shift(); // removes first element and returns that element
friends.slice(2); // returns the element at the index provided in a new array
friends.slice(0, 2); // returns the elements starting at 0 and stops at 2
friends.splice(1, 2); // starting at index 1 return 2 elements
friends.splice(2, 1, "Rachel", "Phoebe"); // we can also add elements where the one is removed

// looping over arrays

// for loop
function characterNamesForLoop(friends) {
  for (let i = 0; i < friends.length; i++) {
    console.log(friends[i]);
  }
}

//do while loop
function characterNamesDoLoop(arr) {
  let i = 0;
  do {
    console.log(arr[i]);
    i++;
  } while (i < arr.length);
}

// for...of loop
function characterNamesForOf(friends) {
  for (const friend of friends) {
    console.log(friend);
  }
}

// while loop
function nextEpisode(i) {
  while (i < 10) {
    console.log(`Up next: Episode ${i}`);
    i++;
  }
  console.log("You are done with this season!");
}

// array methods

//.forEach()
function characterNamesForEach(friends) {
  friends.forEach((friend) => {
    console.log(friend);
  });
}

// .map()
function modifyCharNames(friends) {
  return friends.map((friend) => {
    return console.log(friend);
  });
}

// .filter()
let friends = ["Rachel", "Ross", "Monica", "Joey"];

function filterCharacters(friends, letter) {
  return friends.filter((friend) => {
    return friend.toLowerCase().startsWith(letter);
  });
}

filterCharacters(friends, "r");

// .find()
function findCharacter(character) {
  return friends.find((friend) => {
    return friend === character;
  });
}

//----------------------------------------------------------------

// Objects

// Defining objects:
// Object literal

const episode = {
  season: 4,
  num: 5,
  title: "The One with Joeys New Girlfriend",
  air_date: "October 30, 1997",
  run_time: "22 min",
  printEpisode: function(){console.log(episode.title)}
};

// Accessing object properties

episode["season"]; // should return 4
episode.season; // returns 4

function printEpisodeInfo(obj, property) {
  return obj[property]; // can use bracket notation for placeholders
}

printEpisodeInfo(episode, "season");

// Convert object properties and values into an array

Object.values(episode)
Object.keys(episode)
Object.entries(episode)

// changing a property value
episode.air_date = '10/30/1997'

// removing a property 
delete episode.printEpisode

// Iterate over objects

for (const key in episode){
  console.log(`${key}: ${episode[key]}`)
}