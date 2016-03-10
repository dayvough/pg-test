require_relative '../../app.rb'
require 'rspec'
require 'rack/test'
require 'database_cleaner'

describe 'Users' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should have no users at the start of the test" do
    expect(User.count).to eq(0)
  end

  it "should add a User with proper info" do
    user = User.create(first_name: 'A', last_name: 'B', email: 'C@example.com', password: 'Password123!')
    expect(User.count).to eq(1)
    expect(user.id).to eq(1)
  end

  it "shouldn't add a User with missing info" do
    User.create(first_name: 'ABC')
    expect(User.count).to eq(0)
    User.create(last_name: 'ABC')
    expect(User.count).to eq(0)
    User.create(email: 'ABC')
    expect(User.count).to eq(0)
    User.create(password: 'ABC')
    expect(User.count).to eq(0)
  end

  it "should have the correct attributes" do
    expect(User.count).to eq(0)
    user = User.create(first_name: 'E', last_name: 'F', email: 'G@shirt.ly', password: 'Password123!')
    expect(User.count).to eq(1)
    expect(user.id).to eq(2)
    expect(user.user_id).to eq(user.id)
    expect(user.first_name).to eq('E')
    expect(user.last_name).to eq('F')
    expect(user.email).to eq('G@shirt.ly')
    expect(user.password).to eq('Password123!')
    expect(user.api_key).to eq(user.last_name + user.first_name)
  end

  # Checks if user count equals 3 and ID's progress naturally
  # DB doesn't clean on case so the user ID's keep incrementing
  it "should have the correct ID" do
    expect(User.count).to eq(0)
    user = User.create(first_name: 'E', last_name: 'F', email: 'G@dev.io', password: 'Password123!')
    expect(User.count).to eq(1)
    expect(user.id).to eq(3)
  end

  # RegEx from ActiveRecord docs
  it "should have a valid email" do
    user = User.create(first_name: 'I', last_name: 'J', email: 'K@test.me', password: 'Password123!')
    expect(user.email).to match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  end

  it "should have a valid password" do

  end

  it "shouldn't create a user with an existing email" do
    User.create(first_name: 'M', last_name: 'N', email: 'O@gov.ph', password: 'Password123!')
    User.create(first_name: 'M', last_name: 'N', email: 'O@gov.ph', password: 'Password123!')
    expect(User.count).to eq(1)
  end

  # Paper_trail doesn't make new records, it has a separate versions table
  context "and paper_trail" do
    let(:user) { user = User.create(first_name: 'Q', last_name: 'R', email: 'S@evil.corp', password: 'Password123!') }

    it "should have another version on edit" do
      user.update(first_name: 'R')
      expect(user.versions.size).to eq(2)
    end

    it "should have another version on delete" do
      user.destroy
      expect(user.versions.size).to eq(2)
    end

    it "should reify correctly" do
      expect(user.id).to eq(8)
      expect(user.first_name).to eq('Q')
      user.update(first_name: 'R')
      v = user.versions.last
      user = v.reify
      expect(user.id).to eq(8)
      expect(user.first_name).to eq('Q')
    end
  end

end
