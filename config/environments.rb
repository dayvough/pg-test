configure :development, :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/sinatratest')
end
