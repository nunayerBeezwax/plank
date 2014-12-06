require 'rubygems'
require 'bundler/setup'
Bundler.require

require './plank'
require './sentence_templating'

DB = Neo4j::Session.open :server_db, "http://127.0.0.1:7474"

Dinosaurus.configure do |config|
  config.api_key = '40f9469203847c42b31c096fe358ed4d'
end

def rephrase(input)
	tagger = EngTagger.new
	tagged_array = tagger.add_tags(input).split(" ")

	response = []
  tagged_array.each do |word|
  	results = Dinosaurus.synonyms_of(tagger.strip_tags(word))
  	selection = results.sample
  	response << selection
  end
  # results.sample is a syn...
  puts response.join(" ")
end

communicate()
