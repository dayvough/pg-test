source "https://rubygems.org"

gem "sinatra"
gem "sinatra-activerecord"
gem "pg"
gem "rake"
gem "json"
gem "paper_trail"

group :development do
  gem "foreman"
  gem "shotgun"
end

group :development, :test do
  gem "rspec"
  gem "rack-test"
  gem "guard"
  gem "guard-rspec"
  gem "database_cleaner"
end

group :test do
  gem 'rspec_junit_formatter', '0.2.2'
end