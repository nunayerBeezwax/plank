def communicate
	loop do
		input = gets.chomp
		if input == "quit"
			break 
		end
		rephrase input
	end
end