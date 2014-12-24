# this file is going to be how plank learns.  let's put methods in here
# for turning text into useful database information.  
# Stuff to do: clean text, tag text, lemmatise, n-gram, anaphora...

def template(tokens)
  # this method will take in an array of pos tokens and store the entire array, the sentence
  # pattern, in the db.  if that pattern has been seen before it increments a counter.  this 
  # way, plank can become biased toward common sentence structures in his responses. 
  DB.query("
	MERGE (s:Sentence {pattern: #{tokens}})
	ON CREATE SET s.instances = 0
	ON MATCH SET s.instances = s.instances + 1
  ")
end

# this doesn't have to be so verbose, putses just in there for testing purposes
def learn_sentence_templates(filepath)
	text = IO.read(filepath)
	sentences = sententialize(text)
	sentences_read = 0
	sentences.each do |s| 
		sentences_read += 1
		puts "#{sentences_read}"
		if s != nil 
			template(tokify(s))
			puts "#{s}"
		else
			pass
		end
	end
	puts "#{sentences_read} sentences done"
end

def learn_words
	text = IO.read("data/common_words.txt")
end