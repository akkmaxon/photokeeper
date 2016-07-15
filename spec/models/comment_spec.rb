require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { FactoryGirl.create :user }
  let!(:photo) { FactoryGirl.create :photo, user: user }
  let!(:commenter) { FactoryGirl.create :user }
  let!(:comment) { FactoryGirl.create :comment, photo: photo, user: commenter }

  it 'should be valid' do
    expect(commenter.comments.size).to eq 1
    expect(photo.comments.size).to eq 1
  end

  context 'creating' do
    it 'user can create comment' do
      commenter.comments.create body: 'Bla bla bla', photo: photo
      expect(commenter.comments.size).to eq 2
      expect(user.comments.size).to eq 0
      expect(photo.comments.size).to eq 2
    end
  end

  context 'destroy' do
    it 'user can delete comment' do
      commenter.comments.first.destroy
      expect(commenter.comments.size).to eq 0
      expect(photo.comments.size).to eq 0
    end

    it 'automatically with photo' do
      photo.destroy
      expect(commenter.comments.size).to eq 0
    end
  end
end
