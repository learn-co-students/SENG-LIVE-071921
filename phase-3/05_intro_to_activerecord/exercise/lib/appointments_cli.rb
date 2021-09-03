def start_cli
  puts "Hi! Welcome to the Appointments CLI"
  main_menu
  handle_user_choice
  puts "Thanks for using the appointments CLI!"
end

def main_menu
  puts "Here's what you can do:".cyan
  puts "  1. Add Appointment".cyan
  puts "  2. List appointments".cyan
  puts "  3. Add notes to appointment".cyan
  puts "  4. Cancel appointment".cyan
  puts "  5. View Appointments by Doctor".cyan
  puts "  6. View Appointments by Patient".cyan
  puts "  exit".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def handle_user_choice
  input = gets.chomp 
  while input != "exit" do
    if input == "1"
      add_appointment
    elsif input == "2"
      Appointment.all.each do |appointment|
        appointment.print
      end
    elsif input == "3"
      add_notes
    elsif input == "4"
      cancel_appointment
    elsif input == "5"
      appointments_by_doctor
    elsif input == "6"
      appointments_by_patient
    elsif input == "debug"
      binding.pry
    else 
      puts "Whoops! I didn't understand that command".red
    end
    main_menu
    input = gets.chomp
  end
end

def add_appointment
  print "What time does the appointment start? "
  time = ask_for_input
  puts "What doctor is the appointment with? "
  doctor = prompt_user_to_choose_from_collection(Doctor.all)
  puts "Which patient is this appointment for? "
  patient = prompt_user_to_choose_from_collection(Patient.all)
  print "What is the purpose of your visit? "
  purpose = ask_for_input
  appointment = Appointment.create(
    time: time, 
    doctor: doctor, 
    patient: patient, 
    purpose: purpose
  )
  appointment.print
  appointment
end

def add_notes
  puts "Pick the number matching the appointment you would like to add notes to".cyan
  Appointment.all.each.with_index(1) do |appointment, index|
    puts "#{index}. #{appointment.time} with #{appointment.doctor}"
  end
  input_to_index = ask_for_input.to_i - 1
  appointment_to_notate = Appointment.all[input_to_index]
  puts "What notes would you like to add to the #{appointment_to_notate.time} appointment with #{appointment_to_notate.doctor}?"
  notes = gets.chomp
  appointment_to_notate.notes = "#{appointment_to_notate.notes}\n\n#{notes}"
  appointment_to_notate.save
  appointment_to_notate.print
end

def cancel_appointment
  puts "Pick the number matching the appointment you would like to cancel".cyan
  Appointment.all.each.with_index(1) do |appointment, index|
    puts "#{index}. #{appointment.time} with #{appointment.doctor}"
  end
  input_to_index = ask_for_input.to_i - 1
  appointment_to_cancel = Appointment.all[input_to_index]
  appointment_to_cancel.cancel
  appointment_to_cancel.save
  appointment_to_cancel.print
end

def ask_for_input
  input = gets.chomp
  if input == "exit" 
    puts "Thank you for using the appointments CLI."
    exit
  end
  input
end

def appointments_by_doctor
  # print out a list of doctor's names
  # ask user to choose which doctor's appointments they want to view
  puts "Which doctor do you want to view appointments for?"
  doctor = prompt_user_to_choose_from_collection(Doctor.all)
  puts "Here are the appointments for #{doctor.name}:".light_green
  if doctor.appointments.any?
    doctor.appointments.each do |appointment|
      appointment.print
    end
  else
    puts "No appointments scheduled with #{doctor.name}"
  end
end

def appointments_by_patient
  # print out a list of patient's names
  # ask user to choose which patient's appointments they want to view
  # use your the association methods from the macros to print out a 
  # list of the associated appointmentinstances.
  puts "Which patient do you want to view appointments for?"
  patient = prompt_user_to_choose_from_collection(Patient.all)
  puts "Here are the appointments for #{patient.name}:".light_green
  if patient.appointments.any?
    patient.appointments.each do |appointment|
      appointment.print
    end
  else
    puts "No appointments scheduled with #{patient.name}"
  end
end

def prompt_user_to_choose_from_collection(collection)
  collection.each.with_index(1) do |obj, index|
    puts "#{index}. #{obj.name}"
  end
  input = ask_for_input
  input_to_index = input.to_i - 1
  if input_to_index < 0
    puts "Hmm... I didn't understand that choice!".red
    puts
    puts "Please choose a number that matches the item you'd like to choose".
    prompt_user_to_choose_from_collection(collection)
  else
    collection[input_to_index]
  end
end