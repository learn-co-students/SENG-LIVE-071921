# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dakota = User.create(username: 'dakota', email: 'dakota@flatironschool.com')
sam = User.create(username: 'sam', email: 'sam.boahen@flatironschool.com')

group = Group.create(name: 'Online Software Engineering 071921', location: 'online')

group.members = [dakota, sam]

lecture_1 = group.events.create(
  user: dakota,
  title: 'Rails Fundamentals',
  start_time: 1.hour.ago,
  end_time: 1.hour.from_now
)

lecture_1.attendees = [dakota, sam]