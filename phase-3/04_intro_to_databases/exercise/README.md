## Appointments CLI Part 4
### Key Features we're going to add to our Appointments CLI:

- Add persistence to a database 
  - A Read (SELECT) operation to retrieve persisted appointments 
  - An Create (INSERT INTO) operation to persist appointments

### Key Refactors for Appointments CLI

- Appointment class
  - **refactor your `initialize` method** to use keyword arguments and include default values for id, notes, and canceled (so they can be reloaded from db later)
  - **add a `.new_from_row` method** that takes a row from the database as an argument (a hash with string keys corresponding to the column names and values corresponding to column values). Keyword arguments need to receive a hash with symbol keys, so you'll want to construct the key value pairs yourself within new_from_row. 
    - **Aside:** This hash also includes integer keys so that `[]` notation can be used to access values whether or not the results come in as a hash. **There is a configuration option `DB.results_as_hash = true`** set in the `config/environment.rb` that enables the sqlite3 gem to return queries as arrays of hashes instead of arrays of arrays. The integer keys are added to the hashes so that changing this configuration option to results as hash still allows `[]` notation access by index. This can cause unexpected problems if you're not aware of it, but now you are!
  - **refactor the `.all` method** to make a query to the database to retrieve all persisted appointments. Map over those appointment rows and invoke `.new_from_row` passing each row in turn.
  - **refactor the `#save` method** to check if there is an `id` for the object being saved before doing any SQL.
    - if there is an id, do an UPDATE on the database to set the values of this appointment to the new values in the database for the row WHERE the id matches the object being saved.
    - if there isn't an id, do an INSERT on the database to add a row storing all of that object's attributes. After the insert is complete, query the database for the [`last_insert_rowid()`](https://www.w3resource.com/sqlite/core-functions-last_insert_rowid.php) and assign that id as the value for the `@id` of that appointment.
    - remember to return the object being saved in either case.
  - You'll probably also want to remove the calls to `Appointment.create` at the bottom of `lib/appointment.rb` because they'll now be creating duplicates in the database whenever you run the program if you don't!
  
- In CLI
  - Think about where you're making changes to objects in your application currently. Anywhere you're doing that, make sure you invoke `save` on the object after it's done so that the change persists to the database.
  - Boot it up and try to create a couple of appointments, exit the program, and see if they're still there!

### Logistics

- The code for our cli will be written in the file `lib/appointments_cli.rb`. 
- We'll create another file called `lib/appointment.rb` where we'll define our `Appointment` class
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```
