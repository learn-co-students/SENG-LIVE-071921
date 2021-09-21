# Phase 4, Lecture 2 - Client Server Communication part 1 Exercise

Today's focus:

- building out `create` actions in our controllers
- validating user input
- using strong parameters to specify the allowed parameters for post/patch requests
- returning appropriate status codes

## Reading List Application features list

- Users can create books that have a title, author, description and cover_image_url 
  - the title, author, and description should be required
  - the title should be unique within the scope of an author's books
- Users can add existing books to their reading list 
  - user_books should have a book_id that occurs only once (maximum) for each user_id in the table. (No duplicate user_books for the same user and book)

> **NOTE**: Make sure that you create a `current_user` method in your application controller like we did in the demo so you can build endpoints in a way that will be consistent with our application's functionality after we have authentication configured next week.

Before getting started on the code:

1. Create a postman account and download it if you haven’t already.  [POSTMAN](https://www.postman.com/downloads/)
2. Using the application you created yesterday run your rails server
3. Using postman test the routes you created yesterday with GET requests. 
Note: Review Testing APIs with Postman in phase-4 on canvas if you’re stuck with postman. If you end up with a cors issue, confirm that you’ve configured your cors correctly from yesterday.


## Users can create books

### Request
Say we want to be able to support the following fetch request.
```js
fetch('http://localhost:3000/books', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    title: "Blink",
    author: "Malcolmn Gladwell",
    description: "Cool book about the power of intuitive/automatic thinking"
  })
})
```

### Route

What route do you need to add to support the request above?

```rb

```

### Controller

What changes need to happen in the controller to support this feature?
```rb
class BooksController < ApplicationController
  # ...
  def create
    # fill me in
  end

  # ...
  private

  def book_params
    # fill me in
  end
end
```
### Model
Make sure to add validations to your model
```rb
class Book < ApplicationRecord
  has_many :user_books
  has_many :readers, through: :user_books, source: :user

  # add validations
end

```

### Response

We want our API to check if we've successfully created a book or if some validation error prevented the save. To do this, we'll need to add some conditional logic to the create action:

```rb
class BooksController < ApplicationController
  # ...
  def create
    # add conditional logic with status codes
  end

  # ...
  private

  def book_params
    
  end
end
```

```js
fetch('http://localhost:3000/books', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    title: "Blink",
    author: "Malcolmn Gladwell",
    description: "Cool book about the power of intuitive/automatic thinking"
  })
})
  .then(response => {
    if(response.ok) {
      return response.json()
    } else {
      return Promise.reject(response.json())
    }
  })
  .then(book => {
    console.log(book) // if response was ok
  })
  .catch(errors => {
    console.error(errors) // if response was not ok
  })
```

You can test this one by trying to create the same book twice. It should work the first time, but then give you an error the next time.

## Users can add books to their reading list


### Request

```js
fetch('http://localhost:3000/user_books', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    book_id: 1
  })
})
```

### Route

```rb

```

### Controller

```rb
class UserBooksController < ApplicationController
  # ...
  def create
    # fill me in
  end

  # ...
  private

  def user_book_params
    # fill me in
  end
end
```
### Model
We want to ensure that we aren't creating multiple user books for the same combination of user and book as that would serve no purpose here. Add a validation to make sure this is the case
```rb
class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # add validation
end

```

### Response

We want our API to check if we've successfully created an event or if some validation error prevented the save. To do this, we'll need to add some conditional logic to the create action:

```rb
class UserBooksController < ApplicationController
  # ...
  def create
    # add conditional logic
  end

  # ...
  private

  def user_book_params
    
  end
end
```

```js
fetch('http://localhost:3000/user_books', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    book_id: 1
  })
})
  .then(response => {
    if(response.ok) {
      return response.json()
    } else {
      return Promise.reject(response.json())
    }
  })
  .then(user_book => {
    console.log(user_book) // if response was ok
  })
  .catch(errors => {
    console.error(errors) // if response was not ok
  })
```

You can test this one by trying to submit the request twice, it should work the first time but not the second.