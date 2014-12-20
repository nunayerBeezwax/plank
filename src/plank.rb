def communicate
	loop do
		input = gets.chomp
		if input == "quit"
			break 
		end
    store_template tokify input
  end
end
