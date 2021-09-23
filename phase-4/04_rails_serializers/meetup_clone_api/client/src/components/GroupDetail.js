import React, { useState, useEffect } from 'react'

function GroupDetail({ groupId }) {
  const [group, setGroup] = useState(null)
  
  useEffect(() => {
    fetch(`/groups/${groupId}`)
      .then(res => res.json())
      .then(group => setGroup(group))
  }, [groupId])

  if (group) {
    return (
      <div>
        <h1>{group.name}</h1>
        <h3>{group.founder ? `Founded by: ${group.founder}` : ''}</h3>
        <h2>Members</h2>
        <ul>
          {group.members?.map(member => <li>{member.username}</li>)}
        </ul>
        <h2>Events</h2>
        <ul>
          {group.events?.map((event) => <li>{event.title}</li>)}
        </ul>
      </div>
    )
  } else {
    return (
      <div>
        
      </div>
    )
  }
}

export default GroupDetail