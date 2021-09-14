import React, { useState } from 'react'

function NewThingForm({ addNewThing, spots }) {
  const [name, setName] = useState("");
  const [spotName, setSpotName] = useState("");
  const [category, setCategory] = useState("");
  
  const handleSubmit = (e) => {
    e.preventDefault()
    addNewThing({name, spotName, category})
  }
  return (
    <form onSubmit={handleSubmit}>
      <h2>Add a New Thing</h2>
      <p>
        <label htmlFor="name">Name</label><br/>
        <input
          type="text"
          id="name"
          name="name"
          onChange={(e) => setName(e.target.value)}
          value={name}
        />
      </p>
      <p>
        <label htmlFor="spotName">What spot is it at?</label><br/>
        <input
          type="text"
          id="spotName"
          name="spotName"
          list="spots"
          onChange={(e) => setSpotName(e.target.value)}
          value={spotName}
        />
        <datalist id="spots">
          {spots.map(spot => <option>{spot.name}</option>)}
        </datalist>
      </p>
      <p>
        <label htmlFor="category">Category</label><br/>
        <input
          type="text"
          id="category"
          name="category"
          onChange={(e) => setCategory(e.target.value)}
          value={category}
        />
      </p>
      <button type="submit">Add Thing</button>
    </form>
  )
}

export default NewThingForm
