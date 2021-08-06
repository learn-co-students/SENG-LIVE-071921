# What is fetch?

- The Fetch API is a simpler, easy-to-use version of XMLHttpRequest to consume resources asynchronously
- an interface that allows us to push and pull data from a server 
- it is asynchronous meaning that it will allow any code after it to run while it is being completed
- it is a method that is implicitly ran on the window object

## How to use fetch?

``` fetch(url, [options]) ```

- url will be the path that is being accessed
- options can be a variety of additional information, such as headers, authentication etc.
- by default fetch makes a `get` request

## Promises 

- When a fetch request is completed successfully, it will return a Promise. 
- A promise will have two statuses: Fulfilled or Rejected
- Inside this first promise, there is a response 
- We will want to jsonify this response inside of a promise method `.then` like so:

```fetch(url).then(res => res.json())```

- It is really important to inspect the data structure of the returned response. i.e. `fetch('https://www.themealdb.com/api/json/v1/1/search.php?s=chicken').then(resp => resp.json())` 


## .then()

- since `fetch` is an asynchronous function, we want to ensure that the logic executed on the data received back is only done once the fetch has been resolved.
- that is what `.then()` does 
- we will typically use 2 `.then` methods for every fetch request.
- the first `.then` will turn the response into JSON data for us to parse
- the second `.then` will do something with the data 


## Putting it all together 

                fetch("https://www.themealdb.com/api/json/v1/1/search.php?s=chicken")
                    .then(resp => resp.json())
                    .then(data => {
                        // do something with data and DOM manipulation
                    })

## Handling errors with fetch

- Fetch also has a method `.catch` that we can call on the request
- If an error with the request happens, the reject promise will be returned. 
- The catch method is used to handle reject. 
- The code within catch() will be executed if an error occurs when calling the API of your choice.

                fetch('https://api.openberydb.org/breweries/search?query=12')
                    .then(r => console.log())
                    .then(d => console.log(d))
                    .catch(x => alert(x))


                    .then(function(r){
                        return r.json()
                    })