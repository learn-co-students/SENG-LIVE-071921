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
        print_appointment(appointment)
      end
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
  print "What is the purpose of your visit? "
  purpose = gets.chomp
  appointment = {
    time: time,
    doctor: doctor,
    purpose: purpose
  }
  APPOINTMENTS << appointment
  print_appointment(appointment)
  appointment
end

def print_appointment(appointment)
  puts ""
  puts appointment[:time].light_green
  puts "  Doctor: #{appointment[:doctor]}"
  puts "  Purpose: #{appointment[:purpose]}"
  puts ""
end