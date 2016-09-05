class Board
	DISC = "\u2b24"

	attr_accessor :cols

	def initialize
		@cols = []

		7.times do
			@cols << []
		end	
	end

	def add_disc(col, color)
		@cols[col] << color
	end

	def is_won?
		(0..5).each do |y|
			@cols.each_with_index do |col, x|
				if col[y]
					return true if winning_combo?(x, y)
				end
			end
		end

		false 
	end

	def winning_combo?(x, y)
		vertical(x, y) || horizontal(x,y) || right_diagonal(x,y) || left_diagonal(x,y)
	end

	def vertical(x, y)
		is_match?(x, y, 0, 1) if y < 3
	end

	def horizontal(x, y)
		is_match?(x, y, 1, 0) if x < 4
	end

	def right_diagonal(x, y)
		is_match?(x, y, 1, 1) if y < 3 && x < 4
	end

	def left_diagonal(x, y)
		is_match?(x, y, 1, -1) if y > 2 && x < 4
	end

	def is_match?(x, y, a, b)
		stack = [@cols[x][y]] 
		(1..3).each do |i|
			stack[i] = @cols[x + a * i][y + b * i]
		end

		stack.uniq.length == 1 && stack.length == 4
	end

	def to_s
		board = ''

		5.downto(0) do |i|
			@cols.each do |col|
				board += color("#{DISC} ", col[i])
			end
			board += "\n"
		end

		board
	end

	def color(text, color)
		case color
		when :red then colorize(text, "1;31;44")
		when :yellow then colorize(text, "1;33;44")
		when nil then colorize(text, "1;37;44")
		end
	end

	def colorize(text, color_code)
		"\033[#{color_code}m#{text}\033[0m"
	end
end