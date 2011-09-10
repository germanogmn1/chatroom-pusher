require 'sinatra'
require 'sass'
require 'pusher'
require 'json'

Pusher.app_id = '8316'
Pusher.key = '3c30d268802da61414b2'
Pusher.secret = '3a742740f24b5d3820c7'

get '/' do
  erb :index
end

post '/new_message' do
  Pusher['messaging'].trigger('new_message', params.to_json)
end

post '/client_in' do
  Pusher['messaging'].trigger('client_in', params.to_json)
end

post '/client_out' do
  Pusher['messaging'].trigger('client_out', params.to_json)
end

get '/stylesheets/:file.css' do
  scss :"stylesheets/#{params[:file]}"
end

get '/javascripts/:file.js' do
  coffee :"javascripts/#{params[:file]}"
end

