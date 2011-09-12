require 'sinatra'
require 'sass'
require 'pusher'
require 'json'

Pusher.app_id = '8316'
Pusher.key = '3c30d268802da61414b2'
Pusher.secret = '3a742740f24b5d3820c7'

enable :logging

get '/' do
  erb :index
end

post '/push/*/*' do |channel, event|
  params.delete("splat") # remove url matches from params
  Pusher[channel].trigger event, params.to_json
  # debug
  puts "Pusher: pushed to [#{channel}] event [#{event}] with [#{params.to_json}]"
end

get '/stylesheets/:file.css' do
  scss :"stylesheets/#{params[:file]}"
end

get '/javascripts/:file.js' do
  coffee :"javascripts/#{params[:file]}"
end

