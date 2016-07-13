require 'rails_helper'

RSpec.describe Album do
  let!(:user) { FactoryGirl.create :user }
  let!(:album) { FactoryGirl.create :album, user: user }

  it 'initial state' do
    expect(user.albums.size).to eq 1
    expect(album.user).to eq user
  end

  context 'creating' do
    it 'user creates a new album' do
      user.albums.create FactoryGirl.attributes_for :album
      expect(user.albums.size).to eq 2
      expect(Album.count).to eq 2
    end

    it 'other user creates a new album' do
      other_user = FactoryGirl.create :user
      other_user.albums.create FactoryGirl.attributes_for :album
      expect(Album.count).to eq 2
      expect(user.albums.size).to eq 1
      expect(other_user.albums.size).to eq 1
    end

    it 'album should belong to somebody' do
      expect {
	FactoryGirl.create :album
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context 'updating' do
    it 'successfully' do
      user.albums.first.update title: 'New Title'
      expect(Album.first.title).to eq 'New Title'
    end

    it 'with too long title' do
      album.update title: 'a' * 129
      expect(album.errors.full_messages).
	to contain_exactly 'Title is too long (maximum is 128 characters)'
      expect(Album.first.title.size).to be < 129
    end
  end

  context 'deleting' do
    it 'by user' do
      user.albums.first.destroy
      expect(user.albums.size).to eq 0
      expect(Album.count).to eq 0
    end

    it 'automatically with user' do
      user.destroy
      expect(Album.count).to eq 0
    end
  end
end
