const pokeContainer = document.getElementById("poke-container");
const pokeForm = document.getElementById('poke-form')

function renderPoke(pokemon) {
  const pokeCard = document.createElement("div");
  pokeCard.id = `poke-${pokemon.id}`;
  pokeCard.className = "poke-card";

  const pokeImg = document.createElement("img");
  pokeImg.src = pokemon.img;
  pokeImg.alt = `${pokemon.name} image`;

  const pokeName = document.createElement("h3");
  pokeName.textContent = pokemon.name;

  const pokeLikes = document.createElement("h4");
  pokeLikes.textContent = 'Likes: ';
  
  const likesNum = document.createElement("h5");
  likesNum.id = "like-num"
  likesNum.textContent = pokemon.likes

  const likesBttn = document.createElement("button");
  likesBttn.id = "like-bttn";
  likesBttn.textContent = "<3";
  likesBttn.addEventListener("click", increaseLikes);

  pokeCard.append(pokeImg, pokeName, pokeLikes, likesNum, likesBttn);
  pokeContainer.appendChild(pokeCard);
}

function increaseLikes(event) {
    const likes = event.target.previousElementSibling
    likes.textContent = parseInt(likes.textContent) + 1
}

function createPoke(event) {
  event.preventDefault();
  const form = event.target;
  const poke = {
    id: 6,
    name: form.querySelector("#name-input").value,
    img: form.querySelector("#img-input").value,
    likes: 0,
  };
  renderPoke(poke);
  pokeForm.reset()
}

function init() {
  pokemons.forEach(renderPoke);
  pokeForm.addEventListener('submit', createPoke)
}

init();