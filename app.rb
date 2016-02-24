require "sinatra"
require "sinatra/activerecord"

# set :database, {adapter: "sqlite3", database: "foo.sqlite3"}
set :database, ENV['DATABASE_URL'] || 'postgres://localhost/sinatratest'

get '/' do
  "Hello world!"
end
