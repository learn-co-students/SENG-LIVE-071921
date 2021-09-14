# Sinatra API with React Frontend - React Focus

## API Endpoints

| Endpoint | CRUD Action | Parameters/Request body | returned data |
|---|---|---|---|
| `get '/spots'` | READ | NONE | array of spots |
| `post '/spots'` | CREATE | name in body | created spot |
| `delete '/spots/:id'` | DELETE | id as url parameter | deleted spot |
| `get '/things'` | READ | NONE | array of things (with spot_name and id included) |
| `post '/things'` | CREATE | name, spot_name, category in body| created thing |
| `delete '/things/:id'` | DELETE | id as url parameter | deleted thing |

## React Components

