# Once you have your models defined, uncomment the following 3 lines:
# Doctor.destroy_all
# Patient.destroy_all
# Appointment.destroy_all
#

# Sample data for doctors to use for seeds

# (
#   name: "Dr. Miranda Bailey",
#   specialization: "Chief of Surgery",
#   hospital: "Grey Sloan",
#   gives_lollipop: true
# )

# (
#   name: "Dr. Meredith Grey",
#   specialization: "General Surgery",
#   hospital: "Grey Sloan",
#   gives_lollipop: true
# )

# (
#   name: "Dr. Shaun Murphy",
#   specialization: "Surgical Resident",
#   hospital: "St. Bonaventure",
#   gives_lollipop: false
# )

# (
#   name: "Dr. Audrey Lim",
#   specialization: "Chief of Surgery",
#   hospital: "St. Bonaventure",
#   gives_lollipop: true
# )


# Sample data for patients to use for seeds

# ## Henry had Von-Hippel-Lindau (causes tumors and cysts to grow)

# (
#   name: "Henry Burton",
#   is_insured: false,
#   birthday: Date.new(1975, 7, 15),
#   is_alive: false,
#   is_organ_donor: true
# )


# ## Zola had spina bifida
# (
#   name: "Zola",
#   is_insured: false,
#   birthday: Date.new(2000, 8, 23),
#   is_alive: true,
#   is_organ_donor: true
# )


# ## Kayla had ovarian cancer
# (
#   name: "Kayla Snyder",
#   is_insured: true,
#   insurance_provider: "Blue Shield",
#   birthday: Date.new(1981, 3, 21),
#   is_alive: false,
#   is_organ_donor: true
# )


# Use the data above to create records in the doctors and patients table by:
# - writing out the ruby code that will do so (the `.create` method should help)
# - running `rake db:seed` in your terminal
# - uncomment the lines below to verify that you've create doctors and patients

# puts "#{Patient.count} patients created"
# puts "#{Doctor.count} doctors created"
# puts "try booting up the CLI to add appointments".light_green