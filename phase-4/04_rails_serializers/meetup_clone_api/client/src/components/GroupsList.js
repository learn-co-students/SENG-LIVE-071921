import React, { useState } from 'react'
import { Link } from 'react-router-dom'

function GroupsList({ groups, leaveGroup, joinGroup, createGroup }) {
  const [name, setName] = useState('')
  const [location, setLocation] = useState('')

  const leaveOrJoinButton = (group) => {
    if (group.userGroup) {
      return <button onClick={() => leaveGroup(group.id)}>Leave Group</button>
    } else {
      return <button onClick={() => joinGroup(group.id)}>Join Group</button>
    }
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    createGroup({name, location})
  }
  
  return (
    <div>
      <h1>Groups</h1>
      {groups.map(group => (
        <p><Link to={`groups/${group.id}`}>{group.name}</Link> --- {leaveOrJoinButton(group)}</p>
      ))}
      <h3>Add Group</h3>
      <form onSubmit={handleSubmit}>
        <label htmlFor="name">Name </label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          name="name"
        />
        <label htmlFor="name"> Location </label>
        <input
          type="text"
          value={location}
          onChange={(e) => setLocation(e.target.value)}
          name="location"
        />
        {" "}<button type="submit">Add Group</button>
      </form>
    </div>
  )
}

export default GroupsList