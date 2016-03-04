require "sinatra"
require "sinatra/activerecord"
require "json"
require "./models/user"

# set :database, ENV['DATABASE_URL'] || 'postgres://localhost/sinatratest'
set :database, ENV['DATABASE_URL'] || 'postgres://localhost/sinatratest'

before do
  content_type :json
end

get '/' do
  "Hello world!".to_json
end

# Get All Users
get '/users/?' do
  @users = User.all
  @users.to_json
end

# Get User
get '/users/:id/?' do
  @user = User.find_by(id: params[:id])
  if !@user.nil?
    @user.to_json
  else
    "User not found".to_json
  end
end

# Add User
post '/users/new' do
  @user = User.new(params[:user])
  if @user.save
    redirect '/users'
  else
    "Error"
  end
end

# Edit User
patch '/users/:id/?' do
  @user = User.find_by(id: params[:id])
  if !@user.nil?
    if !params[:user].nil?
      @user.update(params[:user])
      @user.to_json
    else
      "Wrong params".to_json
    end
  else
    "User not found".to_json
  end
end

not_found do
  "Route not found!".to_json
end