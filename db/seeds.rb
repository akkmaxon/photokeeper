USERS = ['Dyadya Fyodor', 'Sharik', 'Matroskin', 'Pechkin']

def email_for(name)
  name = name.gsub(' ', '_')
  "#{name.downcase}@prostokvashino.com"
end

USERS.each do |name|
  user = User.find_or_create_by full_name: name do |u|
    u.email = email_for(name)
    u.full_name = name
    u.password = 'password'
    u.password_confirmation = 'password'
    File.open(Rails.root.join "uploads/seeds/#{name}.jpg") do |f|
      u.avatar = f
    end
    u.gravatar = false
  end

  3.times do
    time_in_past = Time.now - (rand(100000) + 1000)
    album = user.albums.create do |album|
      album.title = Faker::Lorem.word
      album.created_at = time_in_past
      album.updated_at = time_in_past + rand(10)
    end
    (rand(20) + 1).times do
      album.photos.create do |photo|
        photo.title = Faker::Lorem.sentence
        photo.caption = Faker::Lorem.paragraph
        photo.user = user
	File.open(Rails.root.join "uploads/seeds/#{rand(10) + 1}.jpg") do |f|
	  photo.source = f
	end
	photo.created_at = photo.album.created_at
	photo.updated_at = photo.album.created_at + rand(10)
      end
    end
  end
end

Photo.all.each do |photo|
  (rand(5) + 1).times do
    photo.comments.create do |comment|
      comment.body = Faker::Lorem.paragraph
      comment.user = User.find(rand(USERS.count) + 1)
      comment.created_at = comment.updated_at =
	comment.photo.created_at + rand(10)
    end
  end
end

### Creating relationships ###

def create_followings(user, followings)
  followings.each do |f|
    user.follow f
  end
end

pechkin = User.find_by(email: 'pechkin@prostokvashino.com')
dyadya_fyodor = User.find_by(email: 'dyadya_fyodor@prostokvashino.com')
sharik = User.find_by(email: 'sharik@prostokvashino.com')
matroskin = User.find_by(email: 'matroskin@prostokvashino.com')

#Pechkin
create_followings pechkin, [dyadya_fyodor, sharik, matroskin]

#Dyadya Fyodor
create_followings dyadya_fyodor, [sharik, matroskin]

#Sharik
create_followings sharik, [dyadya_fyodor, matroskin]

#Matroskin
create_followings matroskin, [dyadya_fyodor, sharik]
