def pass 
end

def examine_utf(string)
	# 160 is nbsp
	string.chars.map(&:ord)
end

def sententialize(string)
	# add any patterns you want regexed out here.  
	dirtier = string.gsub(/\n|\r|\u0097/, ' ').split(/\.\s*/)
	cleaner = []
	# this is a more thorough version of .strip that catches nbsp, etc.
	dirtier.each { |s| cleaner << s.gsub(/\A\p{Space}*|\p{Space}*\z|\\/, '') }
	# the hope/goal is that cleaner = nice strings each of which are 'one sentence' long
	cleaner
end
