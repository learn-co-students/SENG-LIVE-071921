PROMPT = TTY::Prompt.new(interrupt: :exit)

def start_cli
  puts "Hi! Welcome to the Appointments CLI"
  main_menu
  handle_user_choice
end
  
def main_menu
  puts "Here's what you can do:".cyan
  puts "  1. Enter Appointment Mode".cyan
  puts "  2. Enter Doctor Mode".cyan
  puts "  3. Enter Patient Mode".cyan
  puts "  exit".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def handle_user_choice
  input = ask_for_input
  while input != "exit" do
    if input == "1"
      appointments_mode
    elsif input == "2"
      doctor_mode
    elsif input == "3"
      patient_mode
    elsif input == "debug"
      binding.pry
    else 
      puts "Whoops! I didn't understand that command".red
    end
    main_menu
    input = ask_for_input
  end
end

def appointments_mode
  appointments_mode_options
  input = ask_for_input
  until ["back", "exit"].include?(input.downcase) do
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
    appointments_mode_options
    input = ask_for_input
  end
end

def appointments_mode_options 
  puts "#{'Appointment Mode:'.light_green} #{'Here\'s what you can do:'.cyan}"
  puts "  1. Add Appointment".cyan
  puts "  2. List appointments".cyan
  puts "  3. Add notes to appointment".cyan
  puts "  4. Cancel appointment".cyan
  puts "  5. View Appointments by Doctor".cyan
  puts "  6. View Appointments by Patient".cyan
  puts "  back to return to the main menu".cyan
  puts "  exit to leave the program".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def add_appointment
  input = ""
  questions = [
    "What date is the appointment for? (YYYY/MM/DD) ",
    "What time does the appointment start? ",
    "Select the doctor the appointment is with ",
    "Select the patient the appointment is for ",
    "What is the purpose of your visit? "
  ]
  answers = []
  i = 0 
  until (input.is_a?(String) && input.downcase == "back") || answers.length == 5
    puts questions[i]
    if questions[i].start_with?("Select the doctor")
      input = prompt_user_to_choose_from_collection(Doctor.all)
    elsif questions[i].start_with?("Select the patient")
      input = prompt_user_to_choose_from_collection(Patient.all)
    else
      input = ask_for_input
    end
    answers << input
    i += 1
  end
  if input.is_a?(String) && input.downcase == "back"
    puts "\nmoving back. appointment creation aborted\n\n".red
    return
  end
  appointment = Appointment.create(
    time: DateTime.parse("#{answers[0]} at #{answers[1]}"), 
    doctor: answers[2], 
    patient: answers[3], 
    purpose: answers[4]
  )
  appointment.print
  appointment
end

def add_notes
  puts "Pick the number matching the appointment you would like to add notes to".cyan
  appointment = prompt_user_to_choose_from_collection(Appointment.all)
  puts "What notes would you like to add to the #{appointment.name}?"
  notes = ask_for_input
  appointment.notes = "#{appointment.notes}\n#{notes}"
  appointment.save
  appointment.print
end

def cancel_appointment
  puts "Pick the number matching the appointment you would like to cancel".cyan
  appointment = prompt_user_to_choose_from_collection(Appointment.all)
  return if appointment == "Back"
  appointment.cancel
  appointment.save
  appointment.print
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
  PROMPT.select "" do |menu|
    collection.each.with_index(1) do |obj, index|
      menu.choice "#{index}. #{obj.name}", obj
    end
    menu.choice "Back"
  end
end

def doctor_mode
  doctor_mode_options
  input = ask_for_input
  until ["back", "exit"].include?(input.downcase) do
    if input == "1"
      add_doctor
    elsif input == "2"
      list_doctors
    elsif input == "3"
      update_doctor_specialization
    elsif input == "4"
      delete_appointment
    elsif input == "5"
      view_doctor_patients
    elsif input == "6"
      view_doctor_appointments
    elsif input == "7"
      delete_doctor
    elsif input == "debug"
      binding.pry
    else 
      puts "Whoops! I didn't understand that command".red
    end
    doctor_mode_options
    input = ask_for_input
  end
end

def doctor_mode_options 
  puts "#{'Doctor Mode:'.light_green} #{'Here\'s what you can do:'.cyan}"
  puts "  1. Add Doctor".cyan
  puts "  2. List Doctors".cyan
  puts "  3. Update Doctor's Specialization".cyan
  puts "  4. Delete Appointment".cyan
  puts "  5. View a Doctor's patients".cyan
  puts "  6. View a Doctor's appointments".cyan
  puts "  7. Delete Doctor".cyan
  puts "  back to return to the main menu".cyan
  puts "  exit to leave the program".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def add_doctor
  print "What's the doctor's name? "
  name = ask_for_input
  print "What's the doctor's specialization? "
  specialization = ask_for_input
  print "What hospital does this doctor work in? "
  hospital = ask_for_input
  gives_lollipop = PROMPT.yes?("Does this doctor normally give out lollipops?")
  if [name, specialization, hospital, gives_lollipop].include?("Back")
    puts "moving back. appointment creation aborted".red
    return
  end
  doctor = Doctor.create(
    name: name, 
    specialization: specialization, 
    hospital: hospital, 
    gives_lollipop: gives_lollipop
  )
  doctor.print
  doctor
end

def list_doctors
  puts "All Doctors:"
  puts
  Doctor.all.each do |doctor|
    doctor.print
    puts
  end
  puts
end

def update_doctor_specialization
  puts "Which doctor's specialization would you like to update?"
  doctor = prompt_user_to_choose_from_collection(Doctor.all)
  return if doctor == "Back"
  doctor.print
  print "What would you like to update the Doctor's specialization to? ".cyan
  new_specialization = ask_for_input
  doctor.update_specialization(new_specialization)
  doctor.print
end

def delete_appointment
  puts "Which appointment would you like to delete?"
  appointment = prompt_user_to_choose_from_collection(Appointment.all)
  return if appointment == "Back"
  appointment.destroy
  puts "#{appointment.name} removed"
end

def delete_doctor
  puts "Which doctor would you like to delete?"
  doctor = prompt_user_to_choose_from_collection(Doctor.all)
  return if doctor == "Back"
  doctor.destroy
  puts "#{doctor.name} removed"
end

def view_doctor_patients 
  puts "Which doctor's patients would you like to view?"
  doctor = prompt_user_to_choose_from_collection(Doctor.all)
  return if doctor == "Back"
  if doctor.patients.any?
    puts "Here are all of the patients for #{doctor.name}\n\n".light_green
    doctor.patients.each do |patient|
      patient.print
      puts
    end
  else
    puts "\n#{doctor.name} has no associated patients (this probably means they have no appointments scheduled)\n\n".red
  end
end

def view_doctor_appointments
  puts "Which doctor's appointments would you like to view?"
  doctor = prompt_user_to_choose_from_collection(Doctor.all)
  return if doctor == "Back"
  if doctor.appointments.any?
    puts "Here are all of the appointments for #{doctor.name}\n\n".light_green
    doctor.appointments.each do |appointment|
      appointment.print
      puts
    end
  else
    puts "\n#{doctor.name} has no appointments scheduled\n\n".red
  end
end

def patient_mode
  patient_mode_options
  input = ask_for_input
  until ["back", "exit"].include?(input.downcase) do
    if input == "1"
      add_patient
    elsif input == "2"
      list_patients
    elsif input == "3"
      update_patient_insurance_provider
    elsif input == "4"
      delete_patient
    elsif input == "5"
      view_patient_appointments
    elsif input == "6"
      view_patient_doctors
    elsif input == "debug"
      binding.pry
    else 
      puts "Whoops! I didn't understand that command".red
    end
    patient_mode_options
    input = ask_for_input
  end
end

def patient_mode_options 
  puts "#{'Patient Mode:'.light_green} #{'Here\'s what you can do:'.cyan}"
  puts "  1. Add patient".cyan
  puts "  2. List patients".cyan
  puts "  3. Update patient's Insurance Provider".cyan
  puts "  4. Delete patient".cyan
  puts "  5. View a patient's appointments".cyan
  puts "  6. View a patient's doctors".cyan
  puts "  back to return to the main menu".cyan
  puts "  exit to leave the program".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def add_patient
  print "What's the patient's name? "
  name = ask_for_input
  print "What's the patient's insurance provider? (leave blank if none)"
  insurance_provider = ask_for_input
  print 
  birthday = PROMPT.ask "What is the patient's birthday? " do |q|
    q.convert :date
  end
  is_organ_donor = PROMPT.yes? "Is the patient an organ donor? "
  if [name, insurance_provider, birthday, is_organ_donor].any?{|input| input.downcase == "back"}
    puts "moving back. appointment creation aborted".red
    return
  end
  patient_attributes = {
    name: name,
    birthday: birthday,
    is_organ_donor: is_organ_donor,
    is_alive: true
  }
  if insurance_provider.blank?
    patient_attributes[:is_insured] = false
  else
    patient_attributes[:is_insured] = true
    patient_attributes[:insurance_provider] = insurance_provider
  end
  patient = Patient.create(patient_attributes)
  puts "Patient create successfully".light_green
  puts
  patient.print
  puts
end

def list_patients
  puts "All Patients:"
  puts
  Patient.all.each do |patient|
    patient.print
    puts
  end
  puts
end

def update_patient_insurance_provider
  puts "Which patient's insurance provider would you like to update?"
  patient = prompt_user_to_choose_from_collection(Patient.all)
  return if patient == "Back"
  patient.print
  print "What would you like to update the patient's provider to? ".cyan
  new_provider = ask_for_input
  patient.update_provider(new_provider)
  patient.print
end

def delete_patient
  puts "Which patient would you like to delete?"
  patient = prompt_user_to_choose_from_collection(Patient.all)
  return if patient == "Back"
  patient.destroy
  puts "#{patient.name} removed"
end

def view_patient_appointments
  puts "Which patient's appointments would you like to view?"
  patient = prompt_user_to_choose_from_collection(Patient.all)
  return if patient == "Back"
  if patient.appointments.any?
    puts "Here are all of the appointments for #{patient.name}\n\n".light_green
    patient.appointments.each do |appointment|
      appointment.print
      puts
    end
  else
    puts "\n#{patient.name} has no appointments scheduled\n\n".red
  end
end

def view_patient_doctors
  puts "Which patient's doctors would you like to view?"
  patient = prompt_user_to_choose_from_collection(Patient.all)
  return if patient == "Back"
  if patient.doctors.any?
    puts "Here are all of the doctors for #{patient.name}\n\n".light_green
    patient.doctors.each do |doctor|
      doctor.print
      puts
    end
  else
    puts "\n#{patient.name} has no associated doctors (this probably means they have no appointments scheduled)\n\n".red
  end
end