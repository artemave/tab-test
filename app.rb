require 'sinatra'
require "sinatra/json"
require_relative './lib/note'
require 'active_support/core_ext/hash/slice'

post '/notes' do
  note = Note.create params.slice(*%w[title text password])
  json(id: note.id)
end

get '/notes/:id' do |id|
  note = Note.find(id: id, password: params['password'])
  json note
end
