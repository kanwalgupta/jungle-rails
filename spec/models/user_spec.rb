require 'rails_helper'
 RSpec.describe User, type: :model do
   describe 'Validations' do
    it 'should not save to the db if password or password confirmation are missing' do
      @user = User.new(
        id: 1,
        first_name: "Test User",
        email: "Yayayayaya",
        password: "123456",
        password_confirmation: nil,
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(@user).to_not be_valid
    end
     it 'should not save to the db if password and password confirmation do not match' do
      @user = User.new(
        id: 1,
        first_name: "Test User",
        email: "Yayayayaya",
        password: "123456",
        password_confirmation: "Poop",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(@user).to_not be_valid
    end
     it 'should not save to the db if the email is already taken (case insensitive)' do
      @user1 = User.create(
        id: 1,
        first_name: "Test User 1",
        email: "Yayayayaya",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
      @user2 = User.new(
        id: 2,
        first_name: "Test User 2",
        email: "yayayayaya",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(@user2).to_not be_valid
    end
     it 'should not save to the db if first_name is missing' do
      @user = User.new(
        id: 1,
        first_name: nil,
        email: "Yayayayaya",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(@user).to_not be_valid
    end
     it 'should not save to the db if email is missing' do
      @user = User.new(
        id: 1,
        first_name: "first_name",
        email: nil,
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(@user).to_not be_valid
    end
     it 'should not save to the db if password is less than 6 characters' do
      @user = User.new(
        id: 1,
        first_name: "first_name",
        email: nil,
        password: "12345",
        password_confirmation: "12345",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(@user).to_not be_valid
    end
  end
   describe '.authenticate_with_credentials' do
    it "should not log the user in if their email is not in the database" do
      @user1 = User.create(
        id: 1,
        first_name: "Test User 1",
        email: "yayayayaya@yaya.com",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
      
      @user2 = User.new(
        id: 2,
        first_name: "Test User 2",
        email: "bingo@bango.bongo",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(User.find_by(email: @user2.email)).to be_nil
    end
     it "should not log the user in if their password is not correct" do
      @user1 = User.create(
        id: 1,
        first_name: "Test User 1",
        email: "yayayayaya@yaya.com",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
      
      @user2 = User.new(
        id: 2,
        first_name: "Test User 2",
        email: "bingo@bango.bongo",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "6asd6fdg5asdf6sd5fa",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(User.authenticate_with_credentials(@user2.email, @user2.password)).to be_nil
    end
     it "should log the user in if they entered spaces around their email" do
      @user3 = User.create(
        id: 3,
        first_name: "Test User 3",
        email: "boii@dude.com",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "$2a$10$vlfv5uZWvFKTsPBX.hKJ8uLby5yPPKETZmoCvS7nR1jguH/lH5URO",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(User.authenticate_with_credentials("  boii@dude.com  ", @user3.password)).to_not be_nil
    end
     it "should log the user in if they used incorrect case in their email" do
      @user3 = User.create(
        id: 3,
        first_name: "Test User 3",
        email: "BoIi@duDE.cOm",
        password: "123456",
        password_confirmation: "123456",
        password_digest: "$2a$10$vlfv5uZWvFKTsPBX.hKJ8uLby5yPPKETZmoCvS7nR1jguH/lH5URO",
        created_at: Time.now,
        updated_at: Time.now
      )
       expect(User.authenticate_with_credentials("boii@dude.com", @user3.password)).to_not be_nil
    end
  end
end