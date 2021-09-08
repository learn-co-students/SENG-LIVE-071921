class Patient < ActiveRecord::Base
  has_many :appointments, dependent: :nullify
  has_many :doctors, through: :appointments

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
    self.update(insurance_provider: new_provider, is_insured: true)
  end
end