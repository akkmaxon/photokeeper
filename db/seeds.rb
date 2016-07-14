user = User.find_or_create_by email: 'user@example.com' do |user|
  user.email = 'user@example.com'
  user.full_name = 'Example User'
  user.password = 'password'
  user.password_confirmation = 'password'
end

20.times do
  album = user.albums.create title: Faker::Lorem.word
  (rand(20) + 1).times do
    album.photos.create title: Faker::Lorem.sentence,
      caption: Faker::Lorem.paragraph,
      user: user
  end
end
