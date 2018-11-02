require 'bundler'
Bundler.require

require 'open-uri'
require 'sinatra/flash'
require 'sinatra/json'
require 'json'
require 'webrick/https'
require 'rack/ssl-enforcer'
require 'net/http'
require 'uri'
require 'base64'
require 'pp'
require 'rubygems'
require 'open-uri'
require 'pp'

require_relative 'database/environment'
require_relative 'App'

# Load models
dir = Dir.glob('models/*.rb')
dir.map { |x| require_relative x.to_s }



# Make Slim NICE!
Slim::Engine.set_options pretty: true, sort_attrs: false
Slim::Engine.set_options shortcut: {'&' => {tag: 'input', attr: 'type'}, '#' => {attr: 'id'}, '.' => {attr: 'class'}}



#
# webrick_options = {
#   Port: 443,
#   Host: '0.0.0.0',
#   SSLEnable: true,
#   SSLVerifyClient: OpenSSL::SSL::VERIFY_NONE,
#   SSLCertificate: OpenSSL::X509::Certificate.new(File.open('ssl/server.crt').read),
#   SSLPrivateKey: OpenSSL::PKey::RSA.new(File.open('ssl/server.key').read),
#   SSLCertName: [['CN', WEBrick::Utils.getservername]],
#   app: App
# }

configure :development do
  puts 'In Development Environment'
  run App
end

configure :production do
  puts 'In Production Environment'
  #Rack::Server.start(webrick_options)
end
