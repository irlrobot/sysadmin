#!/usr/local/bin/ruby
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'

get '/styles.css' do
  scss :styles
end

get '/' do
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  @title = "Contact Us"
  slim :contact
end

not_found do
  slim :not_found
end
