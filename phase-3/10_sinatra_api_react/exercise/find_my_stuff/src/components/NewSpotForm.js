import React, { useState }from 'react'


function NewSpotForm() {
  const [name, setName] = useState("")


  return (
    <form>
      <h2>Add a New Spot</h2>
      <p>
        <label htmlFor="name">Spot Name</label><br />
        <input
          type="text"
          name="name"
          id="name"
          value={name}
          onChange={e => setName(e.target.value)}
        />
      </p>
      <button type="submit">Add Spot</button>
    </form>
  )
}

export default NewSpotForm
