#!/usr/bin/env ruby
require './song'
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

get '/styles.css' do
  scss :styles
end

get '/login' do
  slim :login
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/?' do
  slim :home
end

get '/about/?' do
  @title = "All About This Website"
  slim :about
end

get '/contact/?' do
  @title = "Contact Us"
  slim :contact
end

get '/songs/?' do
  @songs = Song.all
  slim :songs
end

get '/songs/new/?' do
  halt(401,'Not Authorized') unless session[:admin]
  @song = Song.new
  slim :new_song
end

get '/songs/:id/?' do
  @song = Song.get(params[:id])
  slim :show_song
end

get '/songs/:id/edit/?' do
  halt(401,'Not Authorized') unless session[:admin]
  @song = Song.get(params[:id])
  slim :edit_song
end

post '/songs/?' do
  song = Song.create(params[:song])
  redirect to("/songs/#{song.id}")
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

put '/songs/:id' do
  song = Song.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
  Song.get(params[:id]).destroy
  redirect to('/songs')
end

not_found do
  slim :not_found
end
