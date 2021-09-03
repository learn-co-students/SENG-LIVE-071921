## Appointments CLI Part 5
### Key Features we're going to add to our Dog Walker CLI:

- Add ActiveRecord and the relationship between Dogs and Walks

### Key Refactors for Dog Walker CLI

Summary:
- Create and run migrations for the `appointments`, `doctors`, and `patients` tables
- Add classes for `Doctor` and `Patient` and have them inherit from `ActiveRecord::Base`
- Have `Appointment` inherit from `ActiveRecord::Base` as well.
- Note the methods from `Appointment` we defined before that are commented out. ActiveRecord gives us these (or handles equivalent tasks) through the inheritance relationship (see below for details).
- Add association macros (`has_many` and `belongs_to`) to `Doctor`, `Patient`, and `Appointment` classes indicating the relationships between instances that will support the features of our CLI.
- Read through CLI code - some adjustments have been made, so you shouldn't have to edit this file, but it could be useful to see how it works.

Details
- Migrations
  - `appointments` table
    - time (string)
    - purpose (string)
    - notes (string)
    - canceled (boolean)
    - doctor_id (foreign_key)
    - patient_id (foreign_key)
  - `doctors` table
    - name (string)
    - specialization (string)
    - hospital (string)
    - gives_lollipop (boolean)
  - `patients` table
    - name (string)
    - is_insured (boolean)
    - insurance_provider (text)
    - birthday (date)
    - is_alive (boolean)
    - is_organ_donor (boolean)
- Appointment class
  - inherit from `ActiveRecord::Base`
  - For the `cancel` method, we'll:
    - toggle the `canceled` column to the opposite of what it currently is instead of manipulating the instance variable.
    - check [these docs on persistence with ActiveRecord](https://api.rubyonrails.org/classes/ActiveRecord/Persistence.html) for ideas about how to do this.
  - Add Association Macros to establish methods that relate an `Appointment` to a `Doctor` and `Patient`.
  - **NO Action Required for following bullets** 
    - by inheriting from `ActiveRecord::Base` we'll get the following methods defined for us:
      - `initialize` (will accept a hash of attributes matching the column names in the appointments table)
      - `.all` will query the database and get all of the appointments and return them in a relation
      - `#save` will persist an instance of the appointment class to the database with an insert for a new record and an update for a record that had already been persisted.
      - `.create(attributes)` method that takes attributes as an argument and will instantiate and save a new instance of the appointment class to the database.
    - We also won't need to use the `.new_from_row` method anymore as ActiveRecord will handle that functionality as well.
    - We'll be using Association Macros to handle retrieving appointments for particular doctors and patients, so I've commented those out and moved those to the bottom of the class as well to underscore just how much functionality we're getting through our inheritance relationship with `ActiveRecord`.
  
- `Doctor` class
  - inherit from `ActiveRecord::Base`
  - add association macros to relate doctors with appointments
- `Patient` class
  - inherit from `ActiveRecord::Base`
  - add association macros to relate patients with appointments
- In `db/seeds.rb` 
  - use the sample data to create seed doctors and patients using the `.create` method
  - remember to uncomment the top three lines that will destroy all of the existing records with the `.destroy_all` method from `ActiveRecord`

- In CLI **No Action Required** (this work is done ahead of time due to time constraints but we'll review it and you can look at this for reference on what's different)
  - The method `prompt_user_to_choose_from_collection(collection)` will print the numbered list of doctors or patients (depending on what's in the collection), ask the user for their choice and return the doctor/patient instance corresponding to their choice. Because we have a couple of places we're doing this now, we can also add in some error handling. If the user types in something that isn't "exit" or a valid number choice, we can show them an error message and ask them to choose again.
  - The `appointments_by_doctor` and `appointments_by_patient` methods will now use association methods (instance methods) to display appointment results rather than a class method directly on the class.
  - The `add_appointment` method now includes choices of doctor and patient from the seeded info in our database and uses those instead of the names to create the relationship.
 

### Logistics

- The code for our cli will be written in the file `lib/appointments_cli.rb`. 
- We'll have a `lib/appointment.rb` file where our `Appointment` class is defined.
- We'll have two new files `lib/doctor.rb` and `lib/patient.rb` where those respective classes will be defined. 
- We need to use `rake` to add migration files to create our database tables
- We'll need to fill in the `db/seeds.rb` file with a bit of seed data for Doctors and patients (appointments can be created solely through the CLI if we so choose)
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```

## Rake

- `rake db:create_migration NAME=create_dogs` - used to create a new migration file complete with proper naming conventions and a timestamped file name
- `rake db:migrate` - used to run a migration on the database
- `rake db:rollback` - used when we discover a problem in a migration we just wrote and want to reverse it, change it and run it again.
- `rake db:seed` - used when we want to add seed data to our database. This command executes all ruby code within the `db/seeds.rb` file.
- `rake -T` - used to list available commands and remind you of all of the above

## Important Documentation Links

- [`ActiveRecord::Migration` for methods used in migrations to change database structure](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html)
- [`TableDefinition` object for adding columns and foreign keys](https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html#method-i-column)
- [`ActiveRecord::Peristence` methods](https://api.rubyonrails.org/classes/ActiveRecord/Persistence.html) for `save`, `update`, and `destroy`
- [`ActiveRecord::Associations::ClassMethods` (for `has_many` and `belongs_to`)](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
- [`ActiveRecord::QueryMethods` for the `where` method](https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where)
- [`ActiveRecord::Relation` for find_or_create_by](https://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-find_or_create_by)