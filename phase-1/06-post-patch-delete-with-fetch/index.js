const pokeContainer = document.getElementById("poke-container");
const pokeForm = document.getElementById("poke-form");

function renderPoke(pokemon) {
  const pokeCard = document.createElement("div");
  pokeCard.id = `poke-${pokemon.id}`;
  pokeCard.className = "poke-card";

  const pokeImg = document.createElement("img");
  pokeImg.src = pokemon.img;
  pokeImg.alt = `${pokemon.name} image`;

  const pokeName = document.createElement("h3");
  pokeName.textContent = pokemon.name;

  const pokeLikes = document.createElement("h3");
  pokeLikes.textContent = "Likes: ";

  const likesNum = document.createElement("h5");
  likesNum.className = "like-num";
  likesNum.textContent = pokemon.likes;

  const likeBttn = document.createElement("button");
  likeBttn.className = "like-bttn";
  likeBttn.textContent = "♥";
  likeBttn.addEventListener("click", () => increaseLike(pokemon));

  const deleteBttn = document.createElement("button");
  deleteBttn.className = "delete-bttn";
  deleteBttn.textContent = "Delete";
  deleteBttn.addEventListener("click", () => deletePokemon(pokemon.id));

  pokeCard.append(pokeImg, pokeName, pokeLikes, likesNum, likeBttn, deleteBttn);
  pokeContainer.appendChild(pokeCard);
}

function deletePokemon(id) {
  // make a fetch request delete
  // pessimist or optimist :: pessimist
  
  fetch(`http://localhost:3000/pokemons/${id}`, { method: "DELETE" })
  .then(resp => resp.json())
  .then(() => document.getElementById(`poke-${pokemon.id}`).remove())
}

function increaseLike(pokemon) {
  //console.log(pokemon)
  // should we be pessimistic or optimistic when updating our html
  // PATCH httb verb
  // what is my endpoint going to be
  const likesElement = event.target.previousElementSibling;
  // const likes = pokemon.likes += 1
  const likes = ++pokemon.likes;
  // likesElement.textContent = likes; //updating the html to new likes
  fetch(`http://localhost:3000/pokemons/${pokemon.id}`, {
    method: "PATCH",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ likes: likes }),
  })
  .then(resp => resp.json())
  .then(data => likesElement.textContent = data.likes)
}

function createPoke(e) {
  e.preventDefault();
  const pForm = e.target;
  const pokeName = pForm.querySelector("#name-input").value;
  const pokeImg = pForm.querySelector("#img-input").value;

  if (pokeName !== "" && pokeImg !== "") {
    const poke = {
      name: pokeName,
      img: pokeImg,
      likes: 0,
    };

    const configObj = {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(poke),
    };

    fetch("http://localhost:3000/pokemons", configObj)
      .then((resp) => resp.json())
      // .then(pokemon => renderPoke(pokemon))
      .then(renderPoke);
    pokeForm.reset(); //clearing the form
  } else {
    alert("Fill in the form!!!");
  }
}

function getPokemons() {
  fetch("http://localhost:3000/pokemons")
    .then((resp) => resp.json())
    .then((pokemons) => {
      // pokemons.forEach(pokemon => renderPoke(pokemon))
      pokemons.forEach(renderPoke);
    })
    .catch(err => alert(err))
}

function init() {
  getPokemons();
  pokeForm.addEventListener("submit", createPoke);
}

init();