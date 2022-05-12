# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

count = 0
3.times do |n|
  name = Faker::Name.name
  describe = "Faker-test"
  count+= 1

  Room.create!(
      id: count,
      name: name,
      describe: describe
    )
end

#sentence = Faker::Movies::StarWars.quote

#Message.create!(
#  room_id: 1,
#  sentence: sentence
#)
