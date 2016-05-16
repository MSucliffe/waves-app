source "https://rubygems.org"

ruby "2.3.1"

gem "flutie"
gem "high_voltage", "~> 3.0.0"
gem "jquery-rails"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "puma"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "title"
gem "uglifier"
gem "bundler-audit", ">= 0.5.0", require: false
gem "dotenv-rails"

group :development do
  gem "quiet_assets"
  gem "rubocop"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
	gem "factory_girl"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4.0"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
end
