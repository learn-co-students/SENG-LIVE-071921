import React, { useState, useEffect } from 'react'
import { Switch, Route } from 'react-router-dom'
import GroupsList from './GroupsList'
import GroupDetail from './GroupDetail'

function GroupsContainer() {
  const [groups, setGroups] = useState([]);
  const [userGroups, setUserGroups] = useState({});

  useEffect(() => {
    fetch("/groups")
      .then(res => res.json())
      .then(groups => setGroups(groups))
    fetch("/user_groups")
      .then(res => res.json())
      .then(userGroups => {
        // Store the userGroups in an object with group_ids as keys.
        // We want to easily access the user's relationship with the
        // group, if we use an object, we won't need to iterate through
        // userGroups while we're traversing groups because we'll 
        // already have the group id and we can use it to access the
        // userGroup if it's there
        let userGroupsMap = userGroups.reduce((obj, userGroup) => {
          obj[userGroup.group_id] = userGroup;
          return obj;
        }, {});
        setUserGroups(userGroupsMap);
      })
  }, [])

  // map over all groups and add the associated userGroup from userGroups
  // it'll be undefined if the user isn't a member of the group
  const groupsWithMembership = () => {
    return groups.map(group => {
      return {
        ...group,
        userGroup: userGroups[group.id]
      }
    })
  }

  const leaveGroup = (groupId) => {
    let userGroupId = userGroups[groupId].id
    return fetch(`/user_groups/${userGroupId}`, {
      method: 'DELETE'
    })
      .then(res => {
        if (res.ok) {
          setUserGroups({
            ...userGroups,
            [groupId]: undefined
          })
        }
      })
  }

  const joinGroup = (groupId) => {
    return fetch('/user_groups', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        group_id: groupId
      })
    })
      .then(res => {
        if (res.ok) {
          return res.json()
        } else {
          return res.json().then(errors => Promise.reject(errors))
        }
      })
      .then(userGroup => {
        setUserGroups({
          ...userGroups,
          [groupId]: userGroup
        })
      })
  }

  const createGroup = (formData) => {
    return fetch("/groups", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formData)
    })
      .then(res => {
        if (res.ok) {
          return res.json()
        } else {
          return res.json().then(errors => Promise.reject(errors))
        }
      })
      .then(group => {
        setGroups(groups.concat(group))
      })
  }

  return (
    <div>
      <Switch>
        <Route
          exact
          path="/groups"
        >
          <GroupsList
            groups={groupsWithMembership()}
            leaveGroup={leaveGroup}
            joinGroup={joinGroup}
            createGroup={createGroup}
          />
        </Route>
        <Route
          exact
          path="/groups/:id"
          render={({ match }) => {
            return <GroupDetail groupId={match.params.id} />
          }}
        />
      </Switch>
    </div>
  )
}

export default GroupsContainer