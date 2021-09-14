import React, { useState, useEffect } from 'react'
import NewThingForm from './NewThingForm'
import NewSpotForm from './NewSpotForm'

export default function ThingFinder() {


  const addNewThing = (formData) => {
    
  }

  const deleteThing = (id) => {

  }

  

  return (
    <div>
      <h1>Find My Stuff</h1>
      <h2>Things</h2>
      <ul>
        {things.map(thing => (
          <li key={thing.id}>
            {thing.name} ({thing.category}) - {thing.spot_name} <button onClick={() => deleteThing(thing.id)}>Delete</button>
          </li>
        ))}
      </ul>
      <NewThingForm spots={spots} />
    </div>
  )
}

