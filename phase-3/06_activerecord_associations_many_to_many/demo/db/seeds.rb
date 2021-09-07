Walk.destroy_all
Feeding.destroy_all
Dog.destroy_all

lennon = Dog.create(name: "Lennon", age: "1 year", breed: "Pomeranian", favorite_treats: "cheese")
memphis = Dog.create(name: "Memphis", age: "2 years", breed: "Greyhound", favorite_treats: "bacon")

lennon.walks.create(time: 4.hours.ago)
lennon.walks.create(time: 6.hours.ago)

lennon.feedings.create(time: 30.minutes.ago)

memphis.walks.create(time: 15.minutes.ago)
memphis.feedings.create(time: 2.hours.ago)