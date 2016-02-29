require "sinatra"
require "sinatra/activerecord"
require "json"
require "./models/user"

set :database, ENV['DATABASE_URL'] || 'postgres://localhost/sinatratest'

before do
  content_type :json
end

get '/' do
  "Hello world!".to_json
end

get '/users' do
  @users = User.all
  @users.to_json
end

post '/users/new' do
  @user = User.new(params[:user])
  if @user.save
    redirect '/users'
  else
    "Error"
  end
end