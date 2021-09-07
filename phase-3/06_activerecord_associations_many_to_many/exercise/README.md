## Appointments CLI Part 6
### Key Features we're going to add to our Appointments CLI:

- Add the relationship between Doctors and Patients through appointments.

### Key Refactors for Appointments CLI

Summary:
- Check and run migrations for the `appointments`, `doctors`, and `patients` tables (note that foreign keys are missing, so you'll have to add those to the appropriate migration before running the migrations)
- Establish a many-to-many relationship between Doctor and Patient
- Check association macros (`has_many`, `belongs_to`, and `has_many, through:`) on `Doctor`, `Patient`, and `Appointment` classes and add any necessary relationship methods.
- complete the `Patient#update_provider(new_provider)` method to allow updating a patient's insurance provider through the CLI.
- complete

Details
- Migrations (**FOREIGN KEYS ARE MISSING, YOU'LL NEED TO ADD THEM IN THE CORRECT TABLE**)
  - `appointments` table
    - time (datetime)
    - purpose (string)
    - notes (string)
    - canceled (boolean)
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
  - after checking/updating the migrations, run `rake db:migrate` and check that the schema looks right.
- `Appointment` class
  - modify/add any association macros if necessary
  - **ADVANCED DELIVERABLE** The appointment time is now a datetime type. If you have extra time, try to add two class methods here, one that returns all upcoming appointments and another that returns all past appointments.
  
- `Doctor` class
  - modify/add any association macros if necessary
  - complete the `update_specialization(new_specialization)` method so it updates the database row with the new value.
- `Patient` class
  - modify/add any association macros if necessary
  - complete the `update_provider(new_provider)` method so it updates the database row with the new value. **NOTE** Consider what should happen if we call this method on a patient who is currently uninsured.
- In `db/seeds.rb` 
  - review code here before running `rake db:seed`

- In CLI **No Action Required** (this work is done ahead of time due to time constraints but we'll review it and you can look at this for reference on what's different)
  - There is 1 main menu now and 3 submenus.

Main menu:
```
Here's what you can do:
  1. Enter Appointment Mode
  2. Enter Doctor Mode
  3. Enter Patient Mode
  exit
Type the number corresponding to your choice, or 'exit' to leave the program
```

Appointment Mode
```
Appointment Mode: Here's what you can do:
  1. Add Appointment
  2. List appointments
  3. Add notes to appointment
  4. Cancel appointment
  5. View Appointments by Doctor
  6. View Appointments by Patient
  back to return to the main menu
  exit to leave the program
Type the number corresponding to your choice, or 'exit' to leave the program
```
Doctor Mode
```
Doctor Mode: Here's what you can do:
  1. Add Doctor
  2. List Doctors
  3. Update Doctor's Specialization
  4. Delete Appointment
  5. View a Doctor's patients
  6. View a Doctor's appointments
  7. Delete Doctor
  back to return to the main menu
  exit to leave the program
Type the number corresponding to your choice, or 'exit' to leave the program
```

Patient Mode
```
Patient Mode: Here's what you can do:
  1. Add patient
  2. List patients
  3. Update patient's Insurance Provider
  4. Delete patient
  5. View a patient's appointments
  6. View a patient's doctors
  back to return to the main menu
  exit to leave the program
Type the number corresponding to your choice, or 'exit' to leave the program
```
### Logistics
 
- We'll have 3 files for our models: `lib/appointment.rb`, `lib/doctor.rb` and `lib/patient.rb` where those respective classes will be defined. 
- We'll need to run `rake db:migrate` to run migrations and `rake db:seed` to add seed data from `db/seeds.rb` file. (appointments will be created solely through the CLI)
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```

### How to Test test out the functionality for today
you'll need to:
- Use the CLI to create a new appointment (Appointment mode - option 1) with an existing Doctor and Patient.
- Use the CLI to view that Patient's doctors (Patient mode - option 6)
- Use the CLI to view that Doctor's patients (Doctor mode - option 5)
- Use the CLI to update a Doctor's specialization (Doctor mode - option 3)
  - You can also follow that up with listing the doctors to confirm that the update went through (Doctor mode - option 2)
- Use the CLI to update a Patient's insurance provider (Patient mode - option 3)
  - You can test that it worked by listing the doctors to confirm that the update went through (Patient mode - option 2)

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