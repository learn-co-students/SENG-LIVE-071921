import React, { useState } from 'react'
import { Link } from 'react-router-dom'

function EventsList({ events, groups, removeRsvpToEvent, cancelEvent, rsvpToEvent, createEvent }) {
  const now = new Date();
  now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')
  const [location, setLocation] = useState('')
  const [startTime, setStartTime] = useState(now.toISOString().slice(0, 16))
  const [endTime, setEndTime] = useState('')
  const [groupName, setGroupName] = useState('')


  const rsvpOrCancelButton = (event) => {
    if (event.user_event) {
      return <button onClick={() => removeRsvpToEvent(event.id)}>Cancel RSVP</button>
    } else {
      return <button onClick={() => rsvpToEvent(event.id)}>RSVP for event</button>
    }
  }

  const cancelEventButton = (event) => {
    if (event.user_is_creator) {
      return <button onClick={() => cancelEvent(event.id)}>Cancel Event</button>
    }
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    createEvent({
      title,
      description,
      location,
      start_time: startTime,
      end_time: endTime,
      group_name: groupName
    })
    setTitle('')
    setDescription('')
    setLocation('')
    setStartTime('')
    setEndTime('')
    setGroupName('')
  }
  
  return (
    <div>
      <h1>Events</h1>
      {events.map(event => (
        <p><Link to={`events/${event.id}`}>{event.title}</Link> --- {rsvpOrCancelButton(event)} {event.user_is_creator && '--- '} {cancelEventButton(event)}</p>
      ))}
      <h3>Add Event</h3>
      <form onSubmit={handleSubmit}>
        <p>
          <label htmlFor="title">Title </label>
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            name="title"
          />
        </p>
        <p>
          <label htmlFor="description"> Description </label>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            name="description"
          />
        </p>
        <p>
          <label htmlFor="name"> Location </label>
          <input
            type="text"
            value={location}
            onChange={(e) => setLocation(e.target.value)}
            name="location"
          />
        </p>
        <p>
          <label htmlFor="start_time"> Start Time </label>
          <input
            type="datetime-local"
            value={startTime}
            onChange={(e) => setStartTime(e.target.value)}
            name="start_time"
          />
        </p>
        <p>
          <label htmlFor="end_time"> End Time </label>
          <input
            type="datetime-local"
            value={endTime}
            onChange={(e) => setEndTime(e.target.value)}
            name="end_time"
          />
        </p>
        <p>
          <label htmlfor="group_name">Group Name </label>
          <input
            type="text"
            name="group_name"
            value={groupName}
            list="groups"
            onChange={(e) => setGroupName(e.target.value)}
          />
          <datalist id="groups">
            {groups.map(group => <option>{group.name}</option>)}
          </datalist>
        </p>
        {" "}<button type="submit">Add Event</button>
      </form>
    </div>
  )
}

export default EventsList
