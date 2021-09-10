## Deliverables:

Build out the following endpoints:

| Endpoint | info from client in request | info from server in response |
|---|---|---|
| `get '/walks'` | none | an array of objects (in JSON format) containing walks, their ids and formatted_time |
| `post '/walks'` | the time of the walk and the dog_ids of the dogs on the walk | the walk in json format (including the formatted_time) |
| `delete '/walks/:id'` | none (except the id of the walk to be deleted) | the deleted walk in JSON format (including the formatted_time) |

## How to Test
- You can test out your progress by using Postman to send requests to the API 
  - make sure that `rake server` is running
  - verifying the responses are what you expect
  - You can also check the `rake server` logs after sending a request through Postman to see the SQL queries fired off
  - check the SQLite explorer to see the impact on your database.
- You can also boot up the react client using `npm start`
  - keep an eye on the network tab in the chrome devtools, this will show you the requests that are being sent and the responses received as well.
  - If you click on the navbar link to `/walks` you should see a list of walks there if you've completed the first endpoint.
  - If you fill in the form in the react client to create a walk, it will appear in the browser if the endpoint is properly configured
  - If you click on the trash can icon in the react client, it should remove the walk from the database. 