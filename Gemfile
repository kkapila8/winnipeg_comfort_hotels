source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.8"

gem "rails", "~> 7.1.0"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 6.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "sprockets-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "bootsnap", require: false

# Feature 3.1.4 - Devise for user authentication (passwords hashed + salted)
gem "devise"
gem "bcrypt", "~> 3.1.7"

# Features 1.1, 1.2, 1.4 - ActiveAdmin dashboard
gem "activeadmin"
gem "sassc-rails"

# Feature 5.2 - Active Storage image uploads
gem "image_processing", "~> 1.2"

# Feature 2.5 - Pagination (kaminari NOT will_paginate - conflicts with activeadmin)
gem "kaminari"

# Feature 4.1.5 - SCSS pre-processor
gem "sass-rails"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end