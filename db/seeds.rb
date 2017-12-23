# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(username: 'admin', password: 'password', password_confirmation: 'password')

10.times do
  room_capacity = [1, 2, 3].sample
  room_name = "Pokój #{room_capacity} osobowy"
  room_price = [120, 230.50, 180].sample
  room_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec sem suscipit, luctus quam quis, gravida enim. Fusce arcu lorem, interdum et lacus vel, finibus eleifend sapien. Etiam sodales urna dolor, ut pulvinar tortor elementum nec. Cras tempor quam ut porta aliquet. Vestibulum gravida leo et nisi tempor, eget luctus justo efficitur."
  room_amount = [1, 2].sample
  Room.create!(name: room_name, capacity: room_capacity, price: room_price, description: room_description, room_amount: room_amount)
  print '.'
end