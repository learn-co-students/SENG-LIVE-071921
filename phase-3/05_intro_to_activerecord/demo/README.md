# Intro to ActiveRecord

## Key Concepts for the day:

- Inheritance
- Rake
- Migrations
- Seeding a database
- Active Record Queries
- Active Record Associations: One to Many
- Has many, belongs to
## Dog Walker CLI Part 5
### Key Features we're going to add to our Dog Walker CLI:

- Add ActiveRecord and the relationship between Dogs and Walks

### Key Refactors for Dog Walker CLI

- Migrations
  - `dogs` table
    - name (string)
    - age (string)
    - breed (string)
    - favorite_treats (string)
    - last_fed_at (datetime)
    - last_walked_at (datetime)
  - `walks` table
    - time (datetime)
    - dog_id (integer foreign key)
  - `feedings` table
    - time (datetime)
    - dog_id (integer foreign key)
- `Walk` Class
  - inherit from `ActiveRecord::Base`
  - add association macro to establish relationship between a walk and a dog
- `Feeding` Class
  - inherit from `ActiveRecord::Base`
  - add association macro to establish relationship between a feeding and a dog
- `Dog` class
  - inherit from `ActiveRecord::Base`
  - add association macros to establish relationship between a dog and walks/feedings
  - by inheriting from `ActiveRecord::Base` we'll get the following methods defined for us:
    - `initialize` (will accept a hash of attributes matching the column names in the dogs table)
    - `.all` will query the database and get all of the dogs and return them in a relation
    - `#save` will persist an instance of the dog class to the database with an insert for a new record and an update for a record that had already been persisted.
    - `.create(attributes)` method that takes attributes as an argument and will instantiate and save a new instance of the dog class to the database.
    - We also won't need to use the `.new_from_row` method anymore as ActiveRecord will handle that functionality as well.
  - For the `walk` method, we'll:
    - update the `last_walked_at` column to the current time
    - and create a new walk at the current time that belongs to the dog.
  - For the `feed` method, we'll
    - update the `last_fed_at` column to the current time
    - create a new feeding at the current time that belongs to the dog.
  - For the `needs_a_walk?` and `needs_a_meal?` we'll use the methods `last_fed_at` and `last_walked_at` instead of accessing instance variable values directly because we want the column values from the database at this point.
  
- In CLI (this work is done ahead of time due to time constraints but we'll review it)
  - Add menu options for viewing all of a dog's walks or feedings.
  - Add `list_walks_for_dog` method that prompts user to choose a dog and then lists that dogs walks after the choice is made.
  - Add `list_feedings_for_dog` method that prompts user to choose a dog and then lists that dogs feedings after the choice is made.
  - Because both of these methods require the user to choose a dog, and we've also needed that functionality a couple of times before when finding a dog to feed or walk, we can pull this functionality out into a separate method now (because we're doing it more than 3 times)
  - The method `prompt_user_to_choose_dog` will print the numbered list of dogs, ask the user for their choice and return the Dog instance corresponding to their choice. Because we have one place we're doing this, we can also add in some error handling. If the user types in something that isn't "exit" or a valid number choice, we can show them an error message and ask them to choose again.

### Logistics

- We'll have a `lib/dog.rb` file where our `Dog` class is defined.
- We'll have two new files `lib/walk.rb` and `lib/feeding.rb` where those respective classes will be defined. 
- The code for our cli is written in the file `lib/dog_walker_cli.rb`. 
- We need to use `rake` to add migration files to create our database tables
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```

## Inheritance

```rb
class CreateDogs < ActiveRecord::Migration[6.1]
end
```

This gives our `CreateDogs` class access to the methods defined within the [`ActiveRecord::Migration` class](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html) that we can use to make changes to our database. 

### What is a database migration?

- We create a file that can keep track of the version of our database schema.
- If we used raw SQL to update our database structure what would happen if we were collaborating with other developers?
    - They create a column we don't have or vice versa
    - we'd have to communicate to the whole team via Slack run this SQL in your terminal... :sweat_smile:
- If we keep track of changes to the database within files that are checked into version control, then when other developers pull down our code, ActiveRecord will actually notify them before they run specs or their server (for a web app) that they have pending migrations they need to run before doing that.

### How do we create a database migration?

- `rake db:create_migration NAME=create_dogs`

```rb
class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    # describe the change we're making to our database
    create_table :dogs do |t|
      puts t.inspect
      t.string :name
      t.string :age
      t.string :breed
    end
  end
end
```
- do we need to add an id column or is it added for us?
  - ActiveRecord will create your id column (primary key) for you. No need to add it to the migration

### When would we need to migrate a database?
- add a column/rename a column/add a new table
- whenever we're changing the database structure
- migrating the database to a new version of the schema

### How do we run a migration?

`rake db:migrate             # Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)`

If you just run `rake db:migrate` all of your migrations that haven't run yet will run. ActiveRecord keeps track of which migrations have been run in a table called `schema_migrations` within your database. If it sees that a migration has run (the version number in its filename is in the `schema_migrations` table) then it won't run the migration again. 

> We don't want migrations to run twice because this would cause errors. If we try to create a table that already exists, for example, SQLite will throw an error.

If we run a migration, notice a mistake and then change it and try to run it again, nothing will happen. If you create multiple migration files at once and then fill in one of them and run it and then go to the other and try to fill that one in and run it. The second one won't run.

If you run `rake db:migrate` and nothing changed. You need to stop and think. What did you just change in a migration? Probably what you need to do is reverse whatever change you made before you do anything (Undo command in editor would be good).

If you need to edit it and run again what do you need to do?

```bash
rake db:rollback            # Rolls the schema back to the previous version (specify steps w/ STEP=n)
```

When you rollback, the last migration runs in reverse. Sometimes if you changed the migration after you ran it, the migration will no longer be reversible.  So, if you have an add_column command and then change the name of the column and try to run it, realize your mistake and then try to roll it back. AR is going to try to remove the column with the new name (which hasn't been added yet). So...

**Run `rake db:rollback` before changing the offending migration**!

## Association Macros

When we go through the exercise of pairing each of our classes up and asking how are these related? One-to-One or One-to-Many? We can follow that up with adding in the [ActiveRecord association macros](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html) for those relationships. In our case, it'll look something like this:

```rb
class Dog < ActiveRecord::Base
  has_many :walks
  has_many :feedings
end

class Walk < ActiveRecord::Base
  belongs_to :dog
end

class Feeding < ActiveRecord::Base
  belongs_to :dog
end
```

In a nutshell, these macros are like `attr_accessor` in that they are defining instance methods in the class matching the name of the symbol passed as an argument. This time, however, the methods will trigger SQL queries and return a single instance or collection of instances depending on which method we invoke.

As with all methods, the reason you define them is so you can call them. So, if you have no reason to call an association method, you also have no reason to add it in your AR models. You want to be thinking about what your feature set is and whether you have a use case for the methods generated by the macros. These docs are also a good place to read about the methods you get access to: [has_many](https://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_many), [belongs_to](https://apidock.com/rails/v5.2.3/ActiveRecord/Associations/ClassMethods/belongs_to). But the [ruby on rails API documentation for ActiveRecord::Associations](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html) is where you'll find more complete details.

## Seeds

Once we have our migrations and association methods set up, we can add some seeds to our database. This will ensure that we don't start from scratch when we run our CLI app.

```rb
Walk.destroy_all
Feeding.destroy_all
Dog.destroy_all

lennon = Dog.create(name: "Lennon", age: "1 year", breed: "Pomeranian", favorite_treats: "cheese")
memphis = Dog.create(name: "Memphis", age: "2 years", breed: "Greyhound", favorite_treats: "bacon")

lennon.walks.create(time: 4.hours.ago)
lennon.walks.create(time: 6.hours.ago)

lennon.feedings.create(time: 30.minutes.ago)

memphis.walks.create(time: 15.minutes.ago)
mephis.feedings.create(time: 2.hours.ago)
```

I've got this code in the `db/seeds.rb` file commented out currently, so we'll want to uncomment it so we can run it and get a couple of dogs in the database as well as some walks and feedings.