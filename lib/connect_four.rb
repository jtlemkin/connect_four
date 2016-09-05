require './lib/board'

class ConnectFour

	def play
		b = Board.new()
		player1 = :yellow
		player2 = :red

		until b.is_won?
			puts b
			player1, player2 = player2, player1
			b.add_disc(get_move(player1), player1)
		end

		puts b
		puts "#{player1} has won the game"
	end

	def get_move(player)
		if player == :red
			col = 0
			until col >= 1 && col <= 7
				puts "Please choose a column (1-7)"
				col = gets.chomp.to_i
			end
			col -= 1
			return col
		else
			move = rand_col
			puts "CP chose #{move + 1}"
			return move
		end
	end

	def rand_col
		rand(7)
	end
end

ConnectFour.new.play