class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  def self.upcoming
    where("time > ?", Time.now)
  end

  def self.past
    where("time < ?", Time.now)
  end

  def name
    "#{self.doctor ? self.doctor.name : 'unknown doctor'} #{self.time} with #{self.patient ? self.patient.name : 'unknown patient'}"
  end

  def cancel
    self.toggle!(:canceled)
  end

  def print
    puts ""
    puts "#{self.formatted_time.light_green} #{self.canceled ? '(CANCELED)'.red : ''}"
    puts "  Doctor: #{self.doctor ? self.doctor.name : 'unknown'}"
    puts "  Patient: #{self.patient ? self.patient.name : 'unknown'}"
    puts "  Purpose: #{self.purpose}"
    puts "  Notes: #{self.notes || 'none'}"
    puts ""
  end

  def formatted_time
    time.strftime('%A, %m/%d %l:%M %p')
  end

end
