require_relative '../app.rb'
require 'rspec'
require 'rack/test'
require 'database_cleaner'

describe 'Users' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should say Hello World" do
    get '/'
    expect(last_response).to be_ok
  end

  it "should be able to make a user" do
    User.create(first_name: 'A', last_name: 'B', email: 'C@example.com', password: 'D')
    expect(User.count).to eq(1)
  end
end