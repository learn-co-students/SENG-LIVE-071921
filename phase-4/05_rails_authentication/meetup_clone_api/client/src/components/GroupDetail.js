import React, { useState, useEffect, useCallback } from 'react'
import { Link } from 'react-router-dom'

function GroupDetail({ groupId, leaveGroup, joinGroup }) {
  const [group, setGroup] = useState(null)

  const fetchGroupCallback = useCallback(() => {
    fetch(`/groups/${groupId}`, {
      credentials: 'include'
    })
      .then(res => res.json())
      .then(group => setGroup(group))
  }, [groupId])
  
  useEffect(() => {
    fetchGroupCallback()
  }, [fetchGroupCallback])

  const leaveOrJoinButton = (group) => {
    if (group.user_group) {
      return (
        <button
          onClick={() => leaveGroup(group.id).then(() => fetchGroupCallback())}
        >
          Leave Group
        </button>
      )
    } else {
      return (
        <button
          onClick={() => joinGroup(group.id).then(() => fetchGroupCallback())}
        >
          Join Group
        </button>
      )
    }
  }

  if(!group){ return <div></div>}
  
  return (
    <div>
      <h1>{group.name}</h1>
      {leaveOrJoinButton(group)}
      <h2>Members</h2>
      <ul>
        {group.members?.map(member => <li>{member.username}</li>)}
      </ul>
      <h2>Events</h2>
      <ul>
        {group.events?.map((event) => <li><Link to={`/events/${event.id}`}>{event.title}</Link></li>)}
      </ul>
    </div>
  )
  
}

export default GroupDetail
