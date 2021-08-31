APPOINTMENTS = []

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
  puts "  exit".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def handle_user_choice
  input = gets.chomp 
  while input != "exit" do
    if input == "1"
      add_appointment
    elsif input == "2"
      APPOINTMENTS.each do |appointment|
        appointment.print
      end
    elsif input == "3"
      add_notes
    elsif input == "4"
      cancel_appointment
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
  time = gets.chomp
  print "What doctor is the appointment with? "
  doctor = gets.chomp
  print "Which patient is this appointment for? "
  patient = gets.chomp
  print "What is the purpose of your visit? "
  purpose = gets.chomp
  appointment = Appointment.new(time, doctor, patient, purpose)
  APPOINTMENTS << appointment
  appointment.print
  appointment
end

def add_notes
  puts "Pick the number matching the appointment you would like to add notes to".cyan
  APPOINTMENTS.each.with_index(1) do |appointment, index|
    puts "#{index}. #{appointment.time} with #{appointment.doctor}"
  end
  input = gets.chomp
  input_to_index = input.to_i - 1
  appointment_to_notate = APPOINTMENTS[input_to_index]
  puts "What notes would you like to add to the #{appointment_to_notate.time} appointment with #{appointment_to_notate.doctor}?"
  notes = gets.chomp
  appointment_to_notate.notes = notes
  appointment_to_notate.print
end

def cancel_appointment
  puts "Pick the number matching the appointment you would like to cancel".cyan
  APPOINTMENTS.each.with_index(1) do |appointment, index|
    puts "#{index}. #{appointment.time} with #{appointment.doctor}"
  end
  input = gets.chomp
  input_to_index = input.to_i - 1
  appointment_to_cancel = APPOINTMENTS[input_to_index]
  appointment_to_cancel.cancel
  appointment_to_cancel.print
end