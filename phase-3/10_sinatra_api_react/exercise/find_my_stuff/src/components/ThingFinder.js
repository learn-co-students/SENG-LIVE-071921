import React, { useState, useEffect } from 'react'
import NewThingForm from './NewThingForm'
import NewSpotForm from './NewSpotForm'

export default function ThingFinder() {
  const [spots, setSpots] = useState([])
  const [things, setThings] = useState([])
  
  useEffect(() => {
    fetch(`${process.env.REACT_APP_API_URL}/spots`)
      .then(res => res.json())
      .then(setSpots)
    fetch(`${process.env.REACT_APP_API_URL}/things`)
      .then(res => res.json())
      .then(setThings)
  }, [])

  const addNewThing = (formData) => {

    const body = JSON.stringify({
      name: formData.name,
      spot_name: formData.spotName,
      category: formData.category || 'no category'
    })

    fetch(`${process.env.REACT_APP_API_URL}/things`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body
    })
      .then(res => res.json())
      .then(newThing => {
        setThings(things.concat(newThing))
      })
    
  }

  const deleteThing = (id) => {
    fetch(`${process.env.REACT_APP_API_URL}/things/${id}`, {
      method: 'DELETE'
    })
      .then(res => res.json())
      .then(deletedThing => setThings(things.filter(thing => thing.id !== deletedThing.id)))
  }

  const addNewSpot = (formData) => {
    
    const body = JSON.stringify({
      name: formData.name
    })

    fetch(`${process.env.REACT_APP_API_URL}/spots`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body
    })
      .then(res => res.json())
      .then(newSpot => {
        setSpots(spots.concat(newSpot))
      })
    
  }

  const deleteSpot = (id) => {
    fetch(`${process.env.REACT_APP_API_URL}/spots/${id}`, {
      method: 'DELETE'
    })
      .then(res => res.json())
      .then(deletedSpot => setSpots(spots.filter(spot => spot.id !== deletedSpot.id)))
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
      <NewThingForm addNewThing={addNewThing} spots={spots} />
      <h2>Spots</h2>
      <ul>
        {spots.map(spot => (
          <li key={spot.id}>
            {spot.name} <button onClick={() => deleteSpot(spot.id)}>Delete</button>
          </li>
        ))}
      </ul>
      <NewSpotForm addNewSpot={addNewSpot} />
    </div>
  )
}

