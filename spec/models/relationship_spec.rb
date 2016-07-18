require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:first_user) { FactoryGirl.create :user }
  let!(:second_user) { FactoryGirl.create :user }

  it 'no relationships' do
    expect(first_user.followers).to eq []
    expect(first_user.following).to eq []
    expect(second_user.followers).to eq []
    expect(second_user.following).to eq []
  end

  it 'first user follow second' do
    first_user.follow(second_user)

    expect(first_user.followers.size).to eq 0
    expect(first_user.following).to eq [second_user]
    expect(second_user.followers).to eq [first_user]
    expect(second_user.following.size).to eq 0
  end

  it 'both sides relationship' do
    first_user.follow(second_user)
    second_user.follow(first_user)

    expect(first_user.followers).to eq [second_user]
    expect(first_user.following).to eq [second_user]
    expect(second_user.followers).to eq [first_user]
    expect(second_user.following).to eq [first_user]
  end

  it 'unfollow other user' do
    first_user.follow(second_user)
    first_user.unfollow(second_user)

    expect(first_user.following).to eq []
    expect(second_user.followers).to eq []
  end
end
