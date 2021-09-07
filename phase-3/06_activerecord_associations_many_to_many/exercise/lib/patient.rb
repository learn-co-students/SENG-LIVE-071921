class Patient < ActiveRecord::Base
  has_many :appointments

  def print
    puts self.name.light_green
    puts "  Birthday: #{self.birthday}"
    puts "  Insured?: #{self.is_insured}"
    if self.is_insured?
      puts "  Insurance Provider: #{self.insurance_provider}"
    end
    puts "  Alive?: #{self.is_alive}"
    puts "  Donor?: #{self.is_organ_donor}"
  end

  def update_provider(new_provider)
    # COMPLETE ME!!! This method should update the patient's insurance provider in the Database
    # NOTE: Make sure to think about what should happen when we update a patient who is currently uninsured
  end
end