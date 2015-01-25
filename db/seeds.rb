# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding database..."
account_types = AccountType.create([{ name: "Admin" }, { name: "Standard" }])
users = User.create(email: "adigitalnative@gmail.com", password: "tsukahara", first_name: "Jacqueline", last_name: "Chenault")

puts "Seed complete."