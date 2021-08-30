# Doctor Appointments CLI Part 1

This code for our appointments CLI is set up in a similar manner to the Dog Walker CLI. The code for our cli will be written in the file `lib/appointments_cli.rb`. We'll start our cli application by running the following command in our terminal:

```bash
./bin/run
```

Here's the flow we're trying to accomplish:

![Program Flow](./program-flow.png)

When it's complete, it should look something like this:

![Appointments CLI Demo](https://res.cloudinary.com/dnocv6uwb/image/upload/v1630334521/appointments-cli-part1_floomb.gif)

## TIPS

If you set up a `debug` option in your menu that opens up a binding.pry session, you can do all sorts of things with that. You can check what's currently inside of `APPOINTMENTS` to test that your add appointment feature is working, but you can also reassign it to something else. So, for example, if you wanted to test out your list appointments menu option without having to go through the CLI again to add the appointments one by one, you could enter your `pry` and paste in the following code (or something like it--feel free to change this so it works with your code):

```rb
APPOINTMENTS = [
  {
    time: "2:00 PM",
    doctor: "Dr. Elvis",
    patient: "Dakota",
    purpose: "Checkup"
  },
  {
    time: "3:30 PM",
    doctor: "Dr. Shannon",
    patient: "Dakota",
    purpose: "Physical"
  }
]
```

then, you can type `exit` to leave the pry and select the `2` option to list the appointments to test out how that's working. This will work particularly well with the advanced deliverables as well.

Advanced Deliverables to add:
- Add another menu option: 3. List Appointments by doctor
  - Choosing this option should print out only the appointments with that particular doctor
- Try adding a Patient name to the appointments as well
- Add another menu option: 4. List Appointments by patient
  - Choosing this option should print out only the appointments with that particular patient

