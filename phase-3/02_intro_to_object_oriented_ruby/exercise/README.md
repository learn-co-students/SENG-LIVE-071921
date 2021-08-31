## Appointments CLI Part 2
### Key Features we're going to add to our Appointments CLI:

- Add the ability to add notes to an appointment
- Add the ability to cancel an appointment

### Key Refactors for Appointments CLI

- create an Appointment class
  - attributes for `time`, `doctor`, `patient`, `purpose`, `notes`, `canceled`
  - add a `notes=` method which sets the value of the `@notes` instance variable to whatever argument we pass to it.
  - add a `cancel` method which sets the `canceled` attribute to `true`
  - add a `print` method which will handle printing the appointment information to the standard output
- In CLI
  - Add menu options for adding notes to and canceling appointments
  - After choosing those options, create logic to allow users to choose which appointment they want to add notes to/cancel
  - rework the parts of the cli that were expecting an appointment hash to work with an appointment instance instead.
    - `APPOINTMENTS` should store an array of instances of the `Appointment` class instead of an array of hashes
    - within the `add_appointment` method, we'll create an instance of the `Appointment` class instead of a hash (also notice there's a patient attribute now as well, so we'll need to ask the user for that also)
    - instead of calling `print_appointment` and passing the appointment hash, we'll invoke `print` directly on the appointment

### Logistics

- The code for our cli will be written in the file `lib/appointments_cli.rb`. 
- We'll create another file called `lib/appointment.rb` where we'll define our `Appointment` class
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```

![Program Flow](./program-flow.png)

### Advanced Deliverables

- Right now, if our program is in one of our 'submenu' methods (`add_appointment` or `add_notes` or `cancel`) and we type `exit` we won't get the intended result. Think about ways we might allow the user to type exit from anywhere in the CLI and have that leave the program.
- Add a `valid?` method to the `Appointment` class to indicate whether the appointment has all of the required information (non-empty string values) for `time`, `doctor`, `patient` and `purpose`. If it doesn't, don't add the appointment to `APPOINTMENTS` and ask the user to input the appointment information again