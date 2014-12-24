def communicate
	loop do
		input = gets.chomp
		if input == "quit"
			break 
		elsif input == "cmd"
			command_mode
		end
    store_template tokify input
  end
end

def command_mode
	puts "Entering command mode, type a method call below \n"
	loop do 
		input = gets.chomp
		eval(input)
	end
end
