require 'sinatra'
require 'sass'
require 'pusher'
require 'json'

get '/' do
  erb :index
end

post '/message' do
  Pusher.app_id = '8316'
  Pusher.key = '3c30d268802da61414b2'
  Pusher.secret = '3a742740f24b5d3820c7'
  
  Pusher['messaging'].trigger('new_message', params.to_json)
end

get '/stylesheets/:file.css' do
  scss :"stylesheets/#{params[:file]}"
end

