## Appointments CLI Part 3
### Key Features we're going to add to our Appointments CLI:

- Add the ability to list appointments by doctor
- Add the ability to list appointments by patient

### Key Refactors for Appointments CLI

- Appointment class
  - refactor your `initialize` method to use keyword arguments
  - add a `.all` method that returns all persisted appointments and create an `@@all` class variable to store them in
  - add a `#save` method which persists the `appointment` receiving the method call to `@@all`. This method should return the appointment we call it on.
  - add a `.create` method which accepts attributes as an argument, uses them to instantiate a new instance of the class, and invokes `.save` on the new instance
  - add a `.by_doctor(doctor)` method which accepts a doctor name as an argument and returns all appointments with that doctor.
  - add a `.by_patient(patient)` method which accepts a patient name as an argument and returns all appointments with that patient.
- In CLI
  - Add menu options for viewing appointments by patient and by doctor (done)
    - There are methods in the `appointments_cli.rb` file called `appointments_by_doctor` and `appointments_by_patient` that will be called when the user chooses them from the main menu. You'll need to fill in the logic for those methods.
  - After choosing one of those menu options, create logic to allow users to choose which doctor/patient they want to view the appointments for.
  - rework the parts of the cli that were expecting to find all of our appointments in `APPOINTMENTS` to now use the `Appointment.all` method instead.
    - We'll use `Appointment.all` instead of `APPOINTMENTS` to access the array of all appointments.
    - within the `add_appointment` method, we'll create an instance of the `Appointment` class using the `Appointment.create` method.

### Logistics

- The code for our cli will be written in the file `lib/appointments_cli.rb`. 
- We'll create another file called `lib/appointment.rb` where we'll define our `Appointment` class
- Again, we'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```

Here's [a quick video](https://res.cloudinary.com/dnocv6uwb/video/upload/v1630485928/lesson-3-exercise-solution-video_kaatpl.mp4) that demonstrates what the CLI should look like when it's done