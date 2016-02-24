require './app'

set :database_file, "database.yml"

run Sinatra::Application
