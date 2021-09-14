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

We'll build the first 4 of these out together and you'll add in the last two in breakouts. A simple has_many belongs_to between thing and spot is set up with migrations and seeds already written. You should be able to migrate and seed the database to have a starting point similar to mine.

If you'd like to code along in this first part, feel free, if not, that's fine. The `exercise` directory will have all of the code we write in the demo portion, so you'll have that when you get started on the exercise as a reference.

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

As far as the react code is concerned, we'll start out with the UI built out, but most of the wiring is missing. So, we'll need to think about how to connect our frontend and backend and what information we need to pass from component to component within the frontend.

## Exercise

- Hook up the form to add a new spot to an API endpoint to enable creating spots from the app. Make sure to update the following places to support this functionality:
  - the `SpotsController`
  - the `NewSpotForm` component
  - the `ThingFinder` component
- Hook up the delete button for spots to an API endpoint to enable deleting spots from the app. Make sure to update the following places to support this functionality:
  - the `SpotsController`
  - the `ThingFinder` component