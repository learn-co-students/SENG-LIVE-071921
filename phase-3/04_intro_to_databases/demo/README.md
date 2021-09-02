# Intro to Databases

## Key Concepts for the day:

- The benefit of databases in applications
- Relationship between a database and an API
- Domain modeling
- Mapping columns and rows to classes and instances
- Basic SQL queries
- Primary Keys
- Foreign Keys

## Agenda

- Part 1 
  - Explanation  database benefits 
  and a bit of a preview of where we’re going with SQL moving forward
  - Apply what we learned in homework to the Dog Walker CLI app
- Part 2 
  - Hop into Google sheets and start talking about database relationships in the context of different domains
  - practice deciding where to put foreign keys
- Optional HW: I have an exercise put together for applying the SQL concepts to the appointments domain, but I'm going to prioritize the domain modeling discussion in Google Sheets for now as it's a more valuable conversation to have for your progress as developers and is a better use of our time in lecture. If you'd like additional practice, feel free to give the exercise a try, but know that we'll doing a pivot tomorrow away from writing raw SQL queries.

## Putting things in Context
Over the last few days we’ve been building out our CLI applications and one of the problems we’ve had is that we have to create new dogs or appointments every time we start the program.

Databases allow us to store our data outside of our code and we can do CRUD and have it persist to the next session.

### ORM Analogy
![analogy](./analogy.png)

![Flow](./object-method-sql-query-return.png)

At the end of the phase, we'll be building out an API that will sit between our React app and our database:

- React App
- Fetch to API
- API interacts with Database
- Sends response back to Browser
- Resolved promise from fetch leads to change in state
- React updates the DOM


Open [Google Sheet](https://docs.google.com/spreadsheets/d/1XV8ixdHveb2Z5aOMQknPdsNCNmo3JZvXX4criCrNXAo/edit#gid=0)

## Dog Walker CLI Part 3
### Key Features we're going to add to our Dog Walker CLI:

- Add persistence
  - A Read (SELECT) operation to retrieve persisted dogs
  - A Create (INSERT INTO) operation to persists dogs
  - An Update (UPDATE) operation to update a persisted dog.

### Key Refactors for Dog Walker CLI

- Dog class
  - **refactor your `initialize` method** to use keyword arguments and include default values for id, last_walked_at, and last_fed_at (so they can be reloaded from db later)
  - **add a `.new_from_row` method** that takes a row from the database as an argument (a hash with string keys corresponding to the column names and values corresponding to column values). Keyword arguments need to receive a hash with symbol keys, so you'll want to construct the key value pairs yourself within new_from_row. 
    - **Aside:** This hash also includes integer keys so that `[]` notation can be used to access values whether or not the results come in as a hash. **There is a configuration option `DB.results_as_hash = true`** set in the `config/environment.rb` that enables the sqlite3 gem to return queries as arrays of hashes instead of arrays of arrays. The integer keys are added to the hashes so that changing this configuration option to results as hash still allows `[]` notation access by index. This can cause unexpected problems if you're not aware of it, but now you are!
  - **refactor the `.all` method** to make a query to the database to retrieve all persisted dogs. Map over those dog rows and invoke `.new_from_row` passing each row in turn.
  - **refactor the `#save` method** to check if there is an `id` for the object being saved before doing any SQL.
    - if there is an id, do an UPDATE on the database to set the values of this dog to the new values in the database for the row WHERE the id matches the object being saved.
    - if there isn't an id, do an INSERT on the database to add a row storing all of that object's attributes. After the insert is complete, query the database for the [`last_insert_rowid()`](https://www.w3resource.com/sqlite/core-functions-last_insert_rowid.php) and assign that id as the value for the `@id` of that dog.
    - remember to return the object being saved in either case.
  - You'll probably also want to remove the calls to `Dog.create` at the bottom of `lib/dog.rb` because they'll now be creating duplicates in the database whenever you run the program if you don't!
  
- In CLI
  - no need to change anything for now
  - Boot it up and try to create a couple of appointments, exit the program, and see if they're still there!

### Logistics

- The code for our cli will be written in the file `lib/dog_walker_cli.rb`. 
- Our class methods will be written in `lib/dog.rb` where our `Dog` class is defined.
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```


## Part 2

### What is the significance of the term: Relational Database 

- Store related data in separate tables
- give us the ability to retrieve the data while maintaining the relationship
- How is this done?
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
![many to many](./many-to-many.png)

Here's the issue
![problem](./the-problem.png)

Here's how we resolve it:

![the-fix](./the-fix.png)

Back to the Sheet