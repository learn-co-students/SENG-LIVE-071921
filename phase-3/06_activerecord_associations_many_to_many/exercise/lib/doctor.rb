class Doctor < ActiveRecord::Base
  has_many :appointments, dependent: :nullify
  # equivalent to:
  # self.has_many(:appointments, { :dependent => :nullify})
  has_many :patients, through: :appointments

  def print
    puts self.name.light_green
    puts "  Specialization: #{self.specialization}"
    puts "  Hospital: #{self.hospital}"
    puts "  Gives Lollipops: #{self.gives_lollipop ? 'true' : 'false'}"
  end

  def update_specialization(specialization)
    self.update(specialization: specialization)
  end
end 