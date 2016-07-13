require 'rails_helper'

RSpec.describe User do 
  describe 'Creating' do
    let(:user) { FactoryGirl.build :user }

    context 'successfully with' do
      it 'all properties' do
	expect(user).to be_valid
      end

      it 'email and passwords properties only' do
	user.full_name = ''
	expect(user).to be_valid
      end

    end

    context 'unsuccessfully with ' do
      it 'all empty fields' do
	user = User.new
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Email can't be blank",
			     "Password can't be blank")
      end

      it 'not unique email' do
	other_user = FactoryGirl.create :user, email: user.email
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Email has already been taken")
      end

      it 'wrong email' do
	user.email = 'bullshit'
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Email is invalid")
      end

      it 'short password(minimum 8 characters)' do
	user.password = user.password_confirmation = 'foo'
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Password is too short (minimum is 8 characters)")
      end

      it 'not matching password and it\'s confirmation' do
	user.password_confirmation = 'confirmation'
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Password confirmation doesn't match Password")
      end
    end
  end

  describe 'Updating' do
    let(:user) { FactoryGirl.create :user }
    
    context 'email with' do
      it 'valid' do
	user.update email: 'valid@email.com'
	expect(user).to be_valid
      end

      it 'invalid' do
	user.update email: 'bullshit'
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Email is invalid")
      end
    end

    context 'password with' do
      it 'valid' do
	user.update_attributes(password: 'newpassword',
			       password_confirmation: 'newpassword')
	expect(user).to be_valid
      end

      it 'short password' do
	user.update_attributes(password: 'foo',
			       password_confirmation: 'foo')
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Password is too short (minimum is 8 characters)")
      end

      it 'not matching password and it\'s confirmation' do
	user.update_attributes(password: 'newpassword',
			       password_confirmation: 'notmatching')
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Password confirmation doesn't match Password")
      end
    end

    context 'full_name with' do
      it 'valid' do
	user.update full_name: 'Valid User'
	expect(user).to be_valid
      end

      it 'too long' do
	user.update full_name: ('a' * 129)
	expect(user).to_not be_valid
	expect(user.errors.full_messages).
	  to contain_exactly("Full name is too long (maximum is 128 characters)")
      end
    end
  end
end
