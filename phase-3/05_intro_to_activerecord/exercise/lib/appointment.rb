class Appointment

  def cancel
    @canceled = true
  end

  def print
    puts ""
    puts "#{self.time.light_green} #{self.canceled ? '(CANCELED)'.red : ''}"
    puts "  Doctor: #{self.doctor.name}"
    puts "  Patient: #{self.patient.name}"
    puts "  Purpose: #{self.purpose}"
    puts "  Notes: #{self.notes || 'none'}"
    puts ""
  end

  # @@all = nil

  # def self.all 
  #   rows = DB.execute("SELECT * FROM appointments")
  #   @@all ||= rows.map do |row|
  #     self.new_from_row(row)
  #   end
  # end

  # def self.new_from_row(row)
  #   self.new(
  #     id: row["id"],
  #     time: row["time"],
  #     doctor: row["doctor"],
  #     patient: row["patient"],
  #     purpose: row["purpose"],
  #     notes: row["notes"],
  #     canceled: row["canceled"]
  #   )
  # end

  # def self.create(attributes)
  #   self.new(attributes).save
  # end

  # def self.by_doctor(doctor)
  #   self.all.filter do |appointment| 
  #     appointment.doctor == doctor
  #   end
  # end

  # def self.by_patient(patient)
  #   self.all.filter do |appointment| 
  #     appointment.patient == patient
  #   end
  # end
  
  # attr_accessor :time, :doctor, :patient, :purpose, :notes, :canceled
  # attr_reader :id
  
  # def initialize(id: nil, time:, doctor:, patient:, purpose:, notes: nil, canceled: nil)
  #   @id = id
  #   @time = time
  #   @doctor = doctor
  #   @patient = patient
  #   @purpose = purpose
  #   @notes = notes
  #   @canceled = canceled
  # end

  # def save
  #   if id
  #     sql = <<-SQL
  #     UPDATE appointments
  #     SET time = ?, doctor = ?, patient = ?, purpose = ?, notes = ?, canceled = ?
  #     WHERE id = #{id}
  #     SQL
  #     DB.execute(sql, time, doctor, patient, purpose, notes, canceled)
  #   else
  #     sql = <<-SQL
  #     INSERT INTO appointments (time, doctor, patient, purpose, notes, canceled)
  #     VALUES (?, ?, ?, ?, ?, ?)
  #     SQL
  #     DB.execute(sql, time, doctor, patient, purpose, notes, canceled)
  #     inserted = DB.execute("SELECT * FROM appointments WHERE id = last_insert_rowid()").first
  #     @id = inserted["id"]
  #     self.class.all << self
  #   end
  #   self
  # end

end
