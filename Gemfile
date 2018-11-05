# Tell bundler where to fetch gems
source 'https://rubygems.org'

# Gems used by all environments (development, production & test)
gem 'nokogiri'
gem "sinatra", ">= 2.0.2"
gem 'sinatra-flash'
gem 'sinatra-partial'
gem 'sinatra-contrib'
gem 'sinatra-default_charset'
gem 'datamapper', '~> 1.2'
gem 'dm-migrations'
gem 'dm-types'
gem 'dm-aggregates'
gem 'dm-serializer'
gem 'dm-timestamps'
gem 'bcrypt'
gem 'json'
gem 'dm-sqlite-adapter'
gem 'openssl'
gem 'slim'
gem 'rack'
gem 'rack-rewrite'
gem 'oauth2'
gem 'httparty'
gem 'byebug'
gem 'rake'
gem 'pony'
gem "ffi", ">= 1.9.24"



# Used during local development (on your own machine)
group :development do
  gem 'rerun', github: 'alexch/rerun'
  gem 'dm-sqlite-adapter'
end

# Used during production (on Heroku), when your application is 'live'
group :production do
  gem 'webrick'
  gem 'rack-ssl-enforcer'
end
