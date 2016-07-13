require 'rails_helper'

RSpec.describe Photo do
  let!(:user) { FactoryGirl.create :user }
  let!(:album) { FactoryGirl.create :album, user: user }
  let!(:photo) { FactoryGirl.create :photo, user: user, album: album }

  it 'initial state' do
    expect(user.photos.size).to eq 1
    expect(album.photos.size).to eq 1
  end

  context 'creating' do
    it 'user creates a new photo' do
      user.photos.create FactoryGirl.attributes_for :photo, album: album
      expect(album.photos.size).to eq 2
      expect(user.photos.size).to eq 2
    end

    it 'other user creates a new photo' do
      other_user = FactoryGirl.create :user
      other_album = FactoryGirl.create :album, user: other_user
      other_user.photos.create FactoryGirl.attributes_for :photo, album: other_album
      expect(Album.count).to eq 2
      expect(Photo.count).to eq 2
      expect(user.photos.size).to eq 1
      expect(other_user.photos.size).to eq 1
    end
  end

  context 'updating' do
    it 'successfully' do
      user.photos.first.update_attributes title: 'New Title',
	caption: 'New Caption'
      expect(Photo.first.title).to eq 'New Title'
      expect(Photo.first.caption).to eq 'New Caption'
    end

    it 'with too long title' do
      user.photos.first.update_attributes title: 'a' * 129,
	caption: 'New Caption'
      expect(Photo.first.title).to_not eq ('a' * 129)
      expect(Photo.first.caption).to_not eq 'New Caption'
    end

    it 'with too long caption' do
      user.photos.first.update_attributes title: 'New Title',
	caption: 'a' * 513
      expect(Photo.first.title).to_not eq 'New Title'
      expect(Photo.first.caption).to_not eq ('a' * 513)
    end
  end

  context 'deleting' do
    it 'by user' do
      user.photos.first.destroy
      expect(Photo.count).to eq 0
      expect(user.photos.size).to eq 0
    end

    it 'automatically with user' do
      user.destroy
      expect(Photo.count).to eq 0
    end

    it 'automatically with album' do
      album.destroy
      expect(Photo.count).to eq 0
    end
  end
end
