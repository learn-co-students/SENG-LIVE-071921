# Sinatra API with React Frontend - React Focus

## API Endpoints

| Endpoint | CRUD Action | Parameters/Request body | returned data |
|---|---|---|---|
| `get '/things'` | READ | NONE | array of things (with spot_name and id included) |
| `post '/things'` | CREATE | name, spot_name, category in body| created thing |
| `delete '/things/:id'` | DELETE | id as url parameter | deleted thing |
| `get '/spots'` | READ | NONE | array of spots |
| `post '/spots'` | CREATE | name in body | created spot |
| `delete '/spots/:id'` | DELETE | id as url parameter | deleted spot |


## React Components

- `src/components/ThingFinder.js`
  - initial Fetches
    - all spots
    - all things
  - Callbacks 
    - addNewThing
    - deleteThing
    - addNewSpot
    - deleteSpot
- `src/components/NewThingForm.js`
- `src/components/NewSpotForm.js`

The frontend will look like this when we're done today:

![Demo of Completed Frontend](https://res.cloudinary.com/dnocv6uwb/image/upload/v1631639944/Screen_Shot_2021-09-14_at_10.18.41_AM_fdk0yn.png)


