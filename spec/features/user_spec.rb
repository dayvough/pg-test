require_relative '../../app.rb'
require 'rspec'
require 'rack/test'
require 'database_cleaner'

set :environment, :test

describe 'Users' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should have no users at the start of the test" do
    expect(User.count).to eq(0)
  end

  it "should be able to add a User with proper info" do
    User.create(first_name: 'A', last_name: 'B', email: 'C', password: 'D')
    expect(User.count).to eq(1)
  end

  it "shouldn't add a User with missing info" do
    User.create(first_name: 'ABC')
    expect(User.count).to eq(0)
  end

end
