let header = document.querySelector("h1.header");
header.textContent = "Flatiron Expense Tracker";

let container = document.createElement('div')
container.id = 'items-container'
document.body.appendChild(container)
document.querySelector('#task').remove()

items.forEach((item) => renderItem(item));

function renderItem(item) {
  let itemDiv = document.createElement("div");
  itemDiv.className = "item";
  itemDiv.id = `item-${item.id}`; 
  
  let amount = document.createElement('li');
  amount.className = 'amount'
  amount.textContent = `Amount: ${item.amount}`
  
  let date = document.createElement('li');
  date.className = 'date'
  date.textContent = `Date: ${item.date}`

  let type = document.createElement('li');
  type.className = 'type'
  type.textContent = `Type: ${item.type}`

  let desc = document.createElement('li');
  desc.className = 'desc'
  desc.textContent = `Desc: ${item.desc}`

  let paymentType = document.createElement('li');
  paymentType.className = 'paymentType'
  paymentType.textContent = `Payment Type: ${item.paymentType}`

  let hr = document.createElement('hr')

  itemDiv.append(date, type, desc, amount, paymentType, hr)
  container.appendChild(itemDiv)
}