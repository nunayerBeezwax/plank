# Create base template path for input.
# Returns an array with ordered parts of speech
# reflecting the input's structure.

def tokify(input)
  tagger = EngTagger.new
  tagged = tagger.get_readable(input).split(" ")

  tokens = []
  tagged.each do |tok|
    tokens << tok.split("/")[1]
  end

  return tokens
end

def store_template(tokens)
  #cypher = ["MERGE (n:Token {type:\"#{tokens[0]}\"})"]

  #(1..tokens.length).each do |i|
    #cypher << "-[:Leads_To]->(:Token {type:\"#{tokens[i]}\"})"
  #end

  #DB.query cypher.join("")

  match = ""
  merge = "MERGE "

  tokens.each_with_index do |t,i|
    match += "MATCH (n#{i}:Token {type:\"#{t}\"})"
    merge += i == tokens.count - 1 ? "(n#{i})" : "(n#{i})-[:LEADS_TO]->"
  end
  DB.query(match + merge)
end
