# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dakota = User.create(username: "Dakota", email: "dakota@flatironschool.com")
sam = User.create(username: "Sam", email: "sam.boahen@flatironschool.com")
marc = User.create(username: "Marc", email: "marc.majcher@flatironschool.com")
shivang = User.create(username: "Shivang", email: "shivang.dave@flatironschool.com")

group = Group.create(name: 'Online Software Engineering 071921', location: 'online')

group.members = [dakota, sam, marc, shivang]

lecture_1 = group.events.create(
  user: dakota,
  title: 'Rails Fundamentals',
  description: 'first lecture in phase 4',
  location: "https://flatironschool.zoom.us/j/96333433409?pwd=dlNrLytiQ3lkTFBFZHQyWW9PZlFuUT09",
  start_time: 1.hour.ago,
  end_time: 1.hour.from_now
)

lecture_1.attendees = [dakota, sam]