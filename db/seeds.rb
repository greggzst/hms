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
  room_name = "#{room_capacity} person room"
  room_price = [120, 230.50, 180].sample
  room_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec sem suscipit, luctus quam quis, gravida enim. Fusce arcu lorem, interdum et lacus vel, finibus eleifend sapien. Etiam sodales urna dolor, ut pulvinar tortor elementum nec. Cras tempor quam ut porta aliquet. Vestibulum gravida leo et nisi tempor, eget luctus justo efficitur."
  room_amount = [1, 2].sample
  room = Room.create!(name: room_name, capacity: room_capacity, price: room_price, description: room_description, room_amount: room_amount)
  room_photos = [
    'https://static.pexels.com/photos/584399/living-room-couch-interior-room-584399.jpeg',
    'http://25cacef59bc4232fc0c9-2edab53a40907c7f87a9f314ea7b177c.r68.cf1.rackcdn.com/XLGallery/Le-Meridien-Piccadilly-Deluxe-Room.jpg',
    'http://monstermathclub.com/wp-content/uploads/2017/04/room-pictures-remarkable-room-pics.jpg',
    'https://www.oberoihotels.com/images/hotels-in-udaipur-udaivilas-resort/rooms-suites/premier-room-semi-private-pool/premier-room-semi-private-pool.jpg',
    'https://www.roomandboard.com/features/main/may_american_made/may_american_made_ani_1.jpg'
  ]

  if [true, false].sample
    room.photos.create!(is_primary: true, remote_image_url: room_photos.sample)
  end
  print '.'
end