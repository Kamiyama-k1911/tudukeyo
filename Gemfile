source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "active_model_serializers", "~> 0.10.0"
gem "bootsnap", ">= 1.4.2", require: false
gem "carrierwave", "~> 2.0"
gem "config"
gem "devise"
gem "devise_token_auth"
gem "mini_magick"
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 4.1"
gem "rack-cors"
gem "rails", "~> 6.0.3", ">= 6.0.3.4"

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "annotate"
  gem "listen", "~> 3.2"
  gem "rails-erd"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
