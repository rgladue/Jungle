require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before do
      @user =
        User.create(
          first_name: 'John',
          last_name: 'Smith',
          email: 'john@smith.ca',
          password: 'smith',
          password_confirmation: 'smith',
        )
    end

    it 'should have all entries filled out' do
      expect(@user).to be_valid
    end

    it 'should have a valid first_name' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it 'should have a valid last_name' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it 'should have a valid email' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it 'should have a unique email' do
      @user2 =
        User.create(
          first_name: 'John',
          last_name: 'Smith',
          email: 'john@smith.ca',
          password: 'smith',
          password_confirmation: 'smith',
        )

      @user2.valid?
      expect(@user2.errors.full_messages).to_not be_empty
    end

    it 'should have matching password and password confirmation entries' do
      @user.password_confirmation = 'smiother'
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it 'should not have an empty password field' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it 'should have a password with a length equal to, or more than 5 characters' do
      @user.password = '123'
      @user.password_confirmation = '123'
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user =
      User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@smith.ca',
        password: 'smith',
        password_confirmation: 'smith',
      )
    end

    it 'should log user in with valid email/password' do
      email = 'john@smith.ca'
      password = 'smith'

      @user2 = User.authenticate_with_credentials(email, password)

      expect(@user2).to eq(@user)
    end

    it 'should still be a valid, even with spaces around email' do
      email = '    john@smith.com  '
      password = 'smith'

      @user2 = User.authenticate_with_credentials(email, password)

      expect(@user2).to eq(@user)
    end

    it 'should still be a valid email, case sensitivity should not matter' do
      email = ' JOHN@smith.com  '
      password = 'smith'

      @user2 = User.authenticate_with_credentials(email, password)

      expect(@user2).to eq(@user)
    end
  end
end