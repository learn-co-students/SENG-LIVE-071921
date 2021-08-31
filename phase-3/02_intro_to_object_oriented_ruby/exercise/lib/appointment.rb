class Appointment
  attr_accessor :time, :doctor, :patient, :purpose, :notes, :canceled
  
  def initialize(time, doctor, patient, purpose)
    @time = time
    @doctor = doctor
    @patient = patient
    @purpose = purpose
    @canceled = false
  end

  def cancel
    @canceled = true
  end

  def print
    puts ""
    puts "#{self.time.light_green} #{self.canceled ? '(CANCELED)'.red : ''}"
    puts "  Doctor: #{self.doctor}"
    puts "  Purpose: #{self.purpose}"
    puts "  Notes: #{self.notes || 'none'}"
    puts ""
  end
end