configure :production, :development do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/sinatra')

  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )

  ActiveRecord::Base.raise_in_transactional_callbacks = true
end

configure :test do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/sinatratest')

  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )

  ActiveRecord::Base.raise_in_transactional_callbacks = true
end