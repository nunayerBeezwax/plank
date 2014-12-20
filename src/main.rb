require 'rubygems'
require 'bundler/setup'
Bundler.require

require './utils'
require './plank.rb'
require './sentence_templating.rb'
require './learn.rb'

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
  puts response.join(" ")
end

# communicate()

# if you run this method with a txt file of some kind, plank will read it, and store 
# to the db, sentence templates for every sentence in the file (or so is the goal).  
# it seems to work pretty well for Huck Finn!

learn_sentence_templates("../corpora/huck_finn.txt")
