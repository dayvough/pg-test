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

  end

end
