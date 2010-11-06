# Edit this Gemfile to bundle your application's dependencies.  
source :gemcutter

gem "rails", "~> 2.3.5"
gem "sqlite3-ruby", :require => "sqlite3"
gem 'will_paginate', '>=2.3.11'
gem "aws-s3", :require => "aws/s3"

# bundler requires these gems in all environments
# gem "nokogiri", "1.4.2"
# gem "geokit"

group :development do
  # bundler requires these gems in development
  # gem "rails-footnotes"
end

group :test do
  # bundler requires these gems while running tests
  # gem "rspec"
  # gem "faker"
  gem "cucumber"
  gem "webrat"
  gem "thoughtbot-factory_girl"
  gem "rspec"
  gem "rspec-rails"
end