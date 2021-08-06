const BASE_URL = 'https://api.openbrewerydb.org/breweries'
const container = document.getElementById('brewery-list')
// console.log(container)

function getBreweries(){
    fetch(BASE_URL) // returns a promise
    .then(resp => resp.json()) // another promise
    .then(breweries => {
        breweries.forEach(renderBrew)
    })
    // .then(breweries => {
    //     breweries.forEach(brew => renderBrew(brew))
    // })
}

function renderBrew(brew){
    const div = document.createElement('div')
    div.id = `brew-card-${brew.id}`

    const header = document.createElement('h3')
    header.textContent = `Name: ${brew.name}`

    // create a p element
    const p = document.createElement('p')
    p.id = `brew-info-${brew.id}`
    p.textContent = `
        Type: ${brew.brewery_type} - 
        City: ${brew.city} -
        State: ${brew.state}
    `
    div.append(header, p)
    container.appendChild(div)

}

document.addEventListener('DOMContentLoaded', getBreweries)


// 1. request a list of breweries
// 2. Append each brewery to the DOM 


// i am getting an array of objects