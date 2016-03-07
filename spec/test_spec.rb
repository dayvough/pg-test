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
    # make user
    # expect count to be 1
    expect(User.count).to eq(0)
  end
end