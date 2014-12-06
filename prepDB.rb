# Prep database before building Plank's brain.
# This script wipes the database, and then adds a node for each part of speech
# that is supported by EngTagger to a locally running Neo4j instance.

require 'neo4j'

# Warn about data deletion
puts "==========="
puts "  WARNING  "
puts "==========="
puts "Continuing will delete ALL data on the currently running neo4j instance."
puts "Do you wish to continue? (yes/no)"

if gets.chomp != "yes" then exit end

# Connect to db
puts "Connecting to database..."
DB = Neo4j::Session.open :server_db, "http://127.0.0.1:7474"

puts "Connected"

puts "Wiping Neo4j instance"
DB.query("MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE r, n")

puts "Creating parts of speech tokens to be used for sentence structure templating"
DB.query('
          CREATE (:Token {type:"CC"}),
                 (:Token {type:"CD"}),
                 (:Token {type:"DET"}),
                 (:Token {type:"EX"}),
                 (:Token {type:"FW"}),
                 (:Token {type:"IN"}),
                 (:Token {type:"JJ"}),
                 (:Token {type:"JJR"}),
                 (:Token {type:"JJS"}),
                 (:Token {type:"LS"}),
                 (:Token {type:"MD"}),
                 (:Token {type:"NN"}),
                 (:Token {type:"NNP"}),
                 (:Token {type:"NNPS"}),
                 (:Token {type:"NNS"}),
                 (:Token {type:"PDT"}),
                 (:Token {type:"POS"}),
                 (:Token {type:"PRP"}),
                 (:Token {type:"PRPS"}),
                 (:Token {type:"RB"}),
                 (:Token {type:"RBR"}),
                 (:Token {type:"RBS"}),
                 (:Token {type:"RP"}),
                 (:Token {type:"SYM"}),
                 (:Token {type:"TO"}),
                 (:Token {type:"UH"}),
                 (:Token {type:"VB"}),
                 (:Token {type:"VBD"}),
                 (:Token {type:"VBG"}),
                 (:Token {type:"VBN"}),
                 (:Token {type:"VBP"}),
                 (:Token {type:"VBZ"}),
                 (:Token {type:"WDT"}),
                 (:Token {type:"WP"}),
                 (:Token {type:"WPS"}),
                 (:Token {type:"WRB"}),
                 (:Token {type:"PP"}),
                 (:Token {type:"PPC"}),
                 (:Token {type:"PPD"}),
                 (:Token {type:"PPL"}),
                 (:Token {type:"PPR"}),
                 (:Token {type:"PPS"}),
                 (:Token {type:"LRB"}),
                 (:Token {type:"RRB"})
         ')

