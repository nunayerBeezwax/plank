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
          CREATE (:Token {pos:"CC"}),
                 (:Token {pos:"CD"}),
                 (:Token {pos:"DET"}),
                 (:Token {pos:"EX"}),
                 (:Token {pos:"FW"}),
                 (:Token {pos:"IN"}),
                 (:Token {pos:"JJ"}),
                 (:Token {pos:"JJR"}),
                 (:Token {pos:"JJS"}),
                 (:Token {pos:"LS"}),
                 (:Token {pos:"MD"}),
                 (:Token {pos:"NN"}),
                 (:Token {pos:"NNP"}),
                 (:Token {pos:"NNPS"}),
                 (:Token {pos:"NNS"}),
                 (:Token {pos:"PDT"}),
                 (:Token {pos:"POS"}),
                 (:Token {pos:"PRP"}),
                 (:Token {pos:"PRPS"}),
                 (:Token {pos:"RB"}),
                 (:Token {pos:"RBR"}),
                 (:Token {pos:"RBS"}),
                 (:Token {pos:"RP"}),
                 (:Token {pos:"SYM"}),
                 (:Token {pos:"TO"}),
                 (:Token {pos:"UH"}),
                 (:Token {pos:"VB"}),
                 (:Token {pos:"VBD"}),
                 (:Token {pos:"VBG"}),
                 (:Token {pos:"VBN"}),
                 (:Token {pos:"VBP"}),
                 (:Token {pos:"VBZ"}),
                 (:Token {pos:"WDT"}),
                 (:Token {pos:"WP"}),
                 (:Token {pos:"WPS"}),
                 (:Token {pos:"WRB"}),
                 (:Token {pos:"PP"}),
                 (:Token {pos:"PPC"}),
                 (:Token {pos:"PPD"}),
                 (:Token {pos:"PPL"}),
                 (:Token {pos:"PPR"}),
                 (:Token {pos:"PPS"}),
                 (:Token {pos:"LRB"}),
                 (:Token {pos:"RRB"})
         ')

