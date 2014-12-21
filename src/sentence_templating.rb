# Create base template path for input.
# Returns an array with ordered parts of speech
# reflecting the input's structure.

def tokify(input)
  tagger = EngTagger.new
  tagged = tagger.get_readable(input)
  tag_array = tagged ? tagged.split(" ") : []

  tokens = []
  tag_array.each do |tok|
    tokens << tok.split("/")[1]
  end

  return tokens
end

def store_template(tokens)
  match = ""
  merge = "MERGE "

  tokens.each_with_index do |t,i|
    match += "MATCH (n#{i}:Token {type:\"#{t}\"})"
    merge += i == tokens.count - 1 ? "(n#{i})" : "(n#{i})-[:LEADS_TO]->"
  end
  DB.query(match + merge)
end
