# - refactor your `initialize` method to use keyword arguments
# - add a `.all` method that returns all persisted appointments and create an `@@all` class variable to store them in
#   - add a `#save` method which persists the `appointment` receiving the method call to `@@all`. This method should return the appointment we call it on.
#   - add a `.create` method which accepts attributes as an argument, uses them to instantiate a new instance of the class, and invokes `.save` on the new instance
#   - add a `.by_doctor(doctor)` method which accepts a doctor name as an argument and returns all appointments with that doctor.
#   - add a `.by_patient(patient)` method which accepts a patient name as an argument and returns all appointments with that patient.
class Appointment
  @@all = nil

  def self.all 
    rows = DB.execute("SELECT * FROM appointments")
    @@all ||= rows.map do |row|
      self.new_from_row(row)
    end
  end

  def self.new_from_row(row)
    self.new(
      id: row["id"],
      time: row["time"],
      doctor: row["doctor"],
      patient: row["patient"],
      purpose: row["purpose"],
      notes: row["notes"],
      canceled: row["canceled"]
    )
  end

  def self.create(attributes)
    self.new(attributes).save
  end

  def self.by_doctor(doctor)
    self.all.filter do |appointment| 
      appointment.doctor == doctor
    end
  end

  def self.by_patient(patient)
    self.all.filter do |appointment| 
      appointment.patient == patient
    end
  end
  
  attr_accessor :time, :doctor, :patient, :purpose, :notes, :canceled
  attr_reader :id
  
  def initialize(id: nil, time:, doctor:, patient:, purpose:, notes: nil, canceled: nil)
    @id = id
    @time = time
    @doctor = doctor
    @patient = patient
    @purpose = purpose
    @notes = notes
    @canceled = canceled
  end

  def save
    if id
      sql = <<-SQL
      UPDATE appointments
      SET time = ?, doctor = ?, patient = ?, purpose = ?, notes = ?, canceled = ?
      WHERE id = #{id}
      SQL
      DB.execute(sql, time, doctor, patient, purpose, notes, canceled)
    else
      sql = <<-SQL
      INSERT INTO appointments (time, doctor, patient, purpose, notes, canceled)
      VALUES (?, ?, ?, ?, ?, ?)
      SQL
      DB.execute(sql, time, doctor, patient, purpose, notes, canceled)
      inserted = DB.execute("SELECT * FROM appointments WHERE id = last_insert_rowid()").first
      @id = inserted["id"]
      self.class.all << self
    end
    self
  end

  def cancel
    @canceled = true
  end

  def print
    puts ""
    puts "#{self.time.light_green} #{self.canceled ? '(CANCELED)'.red : ''}"
    puts "  Doctor: #{self.doctor}"
    puts "  Patient: #{self.patient}"
    puts "  Purpose: #{self.purpose}"
    puts "  Notes: #{self.notes || 'none'}"
    puts ""
  end

end

Appointment.create(
  time: "2:00 PM",
  doctor: "Dr. Drew",
  patient: "D",
  purpose: "Physical"
)

Appointment.create(
  time: "3:00 PM", 
  doctor: "Dr. Zhivago", 
  patient: "D", 
  purpose: "Checkup"
)

Appointment.create(
  time: "5:00 PM", 
  doctor: "Dr. Zhivago", 
  patient: "Laurence Fishburne", 
  purpose: "Checkup"
)