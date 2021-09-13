# Sinatra API Relationships Exercise

Your task for today will be to get the dog walker portion of the application working. In particular, what's currently missing is the ability to see which dogs are on a particular walk. This is happening because the walks are currently not included within the JSON response from the endpoints in the `WalksController`.

Here's what we have in the `WalkDetail` component:

```js
import React from 'react'
import { FaTrash, FaPoop } from 'react-icons/fa';


function WalkDetail({ walk = {}, togglePoo, handleDelete }) {
  const { id, formatted_time, dog_walks } = walk;

  const handlePooClick = (dogWalkId) => {
    togglePoo(id, dogWalkId);
  };

  return (
    <div>
      <h1 className="flex justify-between text-2xl">Walk on {formatted_time} <span className="flex items-center">
        <button onClick={() => handleDelete(id)}><FaTrash size={20} /></button>
      </span></h1>

      <ul className="grid sm:grid-cols-3">
        {dog_walks?.map((dogWalk) => (
          <li key={dogWalk.id} className="flex items-bottom justify-between border-b-2 py-2">
            <span className="pb-1 pt-2 text-center">
              <img
                src={dogWalk.dog.image_url}
                alt={dogWalk.dog.name}
                className="w-20"
              />
              {dogWalk.dog.name}
            </span>
            <span className="flex items-center">
              <button className="p-8" onClick={() => handlePooClick(dogWalk.id)}>
                <FaPoop
                  style={{ color: dogWalk.pooped ? '#000' : '#bbb' }}
                  size={20}
                />
              </button>
            </span>
            {/* */}
          </li>
        ))}
      </ul>
    </div>
  )
}

export default WalkDetail
```

Looking at this carefully, we can reverse engineer the data requirements. Notice at the top of the component when we destructure information from the walk prop:

```js
const { id, formatted_time, dog_walks } = walk;
```

This is telling us that the react client is expecting the `walk` prop to include `dog_walks`. If we look back at where that prop is coming from in the `WalksContainer`:

```js
<Route
  exact
  path="/walks/:id"
  render={({ match }) => (
    <WalkDetail
      togglePoo={togglePoo}
      walk={walks.find(walk => walk.id === parseInt(match.params.id))}
      handleDelete={handleDelete}
    />
  )}
>
```

We're actually passing the `walk` from state that we populated by fetching from `/walks`:

```js
const [walks, setWalks] = useState([]);

useEffect(() => {
  fetch(`${process.env.REACT_APP_API_URL}/walks`)
    .then(res => res.json())
    .then(walks => {
      setWalks(walks)
    })
}, [])
```

So we know that our task is to ensure that the data we expect is appearing within the walks we get back from `/walks`.

So, we know we need the `id`, `formatted_time` and `dog_walks`. If we look farther down in the file we can see what we're doing with the `dog_walks`:

```js
<ul className="grid sm:grid-cols-3">
  {dog_walks?.map((dogWalk) => (
    <li key={dogWalk.id} className="flex items-bottom justify-between border-b-2 py-2">
      <span className="pb-1 pt-2 text-center">
        <img
          src={dogWalk.dog.image_url}
          alt={dogWalk.dog.name}
          className="w-20"
        />
        {dogWalk.dog.name}
      </span>
      <span className="flex items-center">
        <button className="p-8" onClick={() => handlePooClick(dogWalk.id)}>
          <FaPoop
            style={{ color: dogWalk.pooped ? '#000' : '#bbb' }}
            size={20}
          />
        </button>
      </span>
      {/* */}
    </li>
  ))}
</ul>
```

We're iterating over the `dog_walks` and for each one we're accessing the following properties: `id` and `dog`. Within the image tag, we're accessing a couple of properties of the dog as well: 

```js
<span className="pb-1 pt-2 text-center">
  <img
    src={dogWalk.dog.image_url}
    alt={dogWalk.dog.name}
    className="w-20"
  />
  {dogWalk.dog.name}
</span>
```

So, we know that each dog needs to include the `name` and `image_url`. Both of these happen to be columns in the dogs table, so we shouldn't have to do any additional customization there. So, what we're looking for is an API response from `/walks` that looks like this:

```json
[
  {
    "id":1,
    "formatted_time":"Wednesday, 09/08/21 11:59 PM","dog_walks":[]
  },
  {
    "id":2,
    "formatted_time":"Thursday, 09/09/21  8:59 PM",
    "dog_walks":[]
  },
  {
    "id":3,
    "formatted_time":"Thursday, 09/09/21  6:59 PM",
    "dog_walks":[]
  },
  {
    "id":5,"formatted_time":"Monday, 09/13/21  9:55 AM","dog_walks":[
      {
        "id":4,
        "pooped":null,
        "dog_id":2,
        "walk_id":5,
        "dog": {
          "id":2,
          "name":"Molly",
          "birthdate":"2019-06-21",
          "breed":"Terrier / Chihuahua",
          "image_url":"https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229038/EEE90-E50-25-F0-4-DF0-98-B2-0-E0-B6-F9-BAA89_menwgg.jpg"
        }
      },
      {
        "id":5,
        "pooped":null,
        "dog_id":1,
        "walk_id":5,
        "dog":{
          "id":1,
          "name":"Olivia",
          "birthdate":"2018-03-31",
          "breed":"Terrier",
          "image_url":"https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229064/zx6CPsp_d_utkmww.webp"
        }
      },
      {
        "id":6,
        "pooped":null,
        "dog_id":3,
        "walk_id":5,
        "dog":{
          "id":3,
          "name":"Kaya",
          "birthdate":"2017-09-27",
          "breed":"Blueheeler",
          "image_url":"https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229011/8136c615d670e214f80de4e7fcdf8607--cattle-dogs-mans_vgyqqa.jpg"
        }
      }
    ]
  }
]
```
Your task is to adjust the serialize method in the `WalksController` so that it returns the necessary data and the ui looks something like this when you create a walk that has dogs associated with it:

![Completed Example of WalkDetail](https://res.cloudinary.com/dnocv6uwb/image/upload/v1631553176/Screen_Shot_2021-09-13_at_10.12.30_AM_aa6syk.png)