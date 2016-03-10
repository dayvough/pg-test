require_relative '../../app.rb'
require_relative'./helpers.rb'
require 'rspec'
require 'rack/test'
require 'database_cleaner'

RSpec.configure do |c|
  c.include Helpers
end

describe 'User requests' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should work" do
    get '/'
    expect(last_response.body).to eq 'Hello world!'
    expect(last_response.status).to eq 200
  end

  it "should have no users at the start" do
    expect(User.count).to eq 0
    get '/users'
    expect(json_response).to eq []
  end

  let(:user) { user = User.create(first_name: 'Q', last_name: 'R', email: 'S@evil.corp', password: 'Password123!') }
  let(:user_params) { user_params = { :first_name => 'D', :last_name => 'E', :email => 'd23@me.com', :password => 'Password123!' } }

  it "should return all users" do
    get '/users'
    expect(json_response).to eq User.all
  end

  it "should return a single user" do
    get "/users/#{user.id}"
    expect(last_response.body).to eq User.last.to_json
  end

  it "should create a new user" do
    post '/users/new', { :user => user_params }
    user = User.last
    ver  = user.versions.last
    expect(ver.event).to eq 'create'
  end

  it "should return an updated user" do
    patch '/users/' + user.id.to_s, { :user => { :first_name => "Q" } }
    expect(user.first_name).to eq "Q"
  end

  it "should delete a user" do
    post '/users/new', { :user => user_params }
    user = User.last
    ver  = user.versions.last
    expect(ver.event).to eq 'create'
  end

  it "should return an error if user isn't found" do
    get '/users/999'
    expect(last_response.body).to eq "User not found"
  end
end