require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should be valid with valid attributes" do
      @user = User.new(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'mattmatt')
      expect(@user).to be_valid
    end

    it "should not be valid without a first name" do
      @user = User.new(first_name: nil, last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'mattmatt')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it "should not be valid without a last name" do
      @user = User.new(first_name: 'Matt', last_name: nil, email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'mattmatt')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it "should not be valid without an email" do
      @user = User.new(first_name: 'Matt', last_name: 'Kelly', email: nil, password: 'mattmatt', password_confirmation: 'mattmatt')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it "should not be valid without a password" do
      @user = User.new(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: nil, password_confirmation: 'mattmatt')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it "should not be valid without a password confirmation" do
      @user = User.new(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
    end

    it "should not be valid if password and password_confirmation do not match" do
      @user = User.new(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'MATTMATT')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it "should not be valid if email is not unique" do
      User.create!(first_name: 'Matt', last_name: 'Kelly', email: 'bob@bob.BOB', password: 'mattmatt', password_confirmation: 'mattmatt')
      @user = User.new(first_name: 'Mark', last_name: 'Kelly', email: 'BOB@BOB.bob', password: 'markmark', password_confirmation: 'markmark')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Email has already been taken"
    end

    it "should not be valid if password is less than 5 characters" do
      @user = User.new(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'matt', password_confirmation: 'matt')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    it "should successfully login with valid attributes" do
      @user1 = User.create!(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'mattmatt')
      @user = User.authenticate_with_credentials('matt@matt.matt', 'mattmatt')
      expect(@user).to eq(@user1)
    end

    it "should not login with the wrong password" do
      @user1 = User.create!(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'mattmatt')
      @user = User.authenticate_with_credentials('matt@matt.matt', 'mattmat')
      expect(@user).to_not eq(@user1)
    end

    it "should successfully login with whitespace around email" do
      @user1 = User.create!(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'mattmatt')
      @user = User.authenticate_with_credentials('    matt@matt.matt  ', 'mattmatt')
      expect(@user).to eq(@user1)
    end

    it "should successfully login with wrong case in email" do
      @user1 = User.create!(first_name: 'Matt', last_name: 'Kelly', email: 'matt@matt.matt', password: 'mattmatt', password_confirmation: 'mattmatt')
      @user = User.authenticate_with_credentials('mAtT@MaTt.mATT', 'mattmatt')
      expect(@user).to eq(@user1)
    end
  end
end
