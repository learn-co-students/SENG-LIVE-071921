class Doctor < ActiveRecord::Base
  has_many :appointments

  def print
    puts self.name.light_green
    puts "  Specialization: #{self.specialization}"
    puts "  Hospital: #{self.hospital}"
    puts "  Gives Lollipops: #{self.gives_lollipop ? 'true' : 'false'}"
  end

  def update_specialization(specialization)
    # COMPLETE ME!!! This method should update the doctor's specialization in the database
  end
end 