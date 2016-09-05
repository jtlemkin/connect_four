require 'board'

def display(board)
	puts " "
	puts board
end

describe Board do

	let(:board) {Board.new}

	describe ".new" do
		it 'creates an instance of the Board class' do
			expect(board).to be_instance_of(Board)
		end

		it 'should have seven columns' do
			expect(board.cols.size).to eq(7)
		end
	end

	describe ".add_disc" do

		before do
			board.add_disc(0, :red)
		end

		context "when red disc added to column" do
			it "should have a length of 1" do
				expect(board.cols[0].length).to eq(1)
			end

			it "should be red" do
				expect(board.cols[0][0]).to eq(:red)
			end

			context "when the column is full" do
				it "should not add a disc" do
					5.times {board.add_disc(0, :yellow)}
					expect(board.cols[0].length).to eq(6)
				end
			end
		end
	end

	describe ".is_won?" do

		context "when four red discs are stacked vertically" do
			it "should return true" do
				4.times {board.add_disc(0, :red)}
				expect(board.is_won?).to eq(true)
				display(board)
			end
		end

		context "when four yellow discs are stacked horizontally" do
			it "should return true" do
				4.times {|i| board.add_disc(i, :yellow)}
				expect(board.is_won?).to eq(true)
				display(board)
			end
		end

		context "when four discs are stacked horizontally on top" do
			it "should return true" do
				4.times do |x|
					board.cols[x][5] = :yellow
				end
				expect(board.is_won?).to eq(true)
			end
		end

		context "when four red discs are stacked diagonally to the right" do
			it "should return true" do
				(1..3).each do |i|
					i.times do |x|
						board.add_disc(i, :yellow)
					end
				end
				4.times do |i|
					board.add_disc(i, :red)
				end
				expect(board.is_won?).to eq(true)
				display(board)
			end
		end

		context "when four yellow discs are stacked diagonally to the left" do
			it "should return true" do
				(0..2).each do |x|
					(3 - x).times do
						board.add_disc(x, :red)
					end
				end
				4.times do |i|
					board.add_disc(i, :yellow)
				end
				expect(board.is_won?).to eq(true)
				display(board)
			end
		end

		context "when board is empty" do
			it "should return false" do
				expect(board.is_won?).to eq(false)
				display(board)
			end
		end

		context "when stack and no win condition" do
			it "should return false" do
				(0..2).each do |x|
					(3 - x).times do
						board.add_disc(x, :red)
					end
				end
				expect(board.is_won?).to eq(false)
				display(board)
			end
		end

		context "when no win conditions present" do
			it "should return false" do
				board.add_disc(0, :red)
				board.add_disc(6, :yellow)
				expect(board.is_won?).to eq(false)
				display(board)
			end
		end

	end

end