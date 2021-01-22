# University of Washington, Programming Languages, Homework 6, hw6runner.rb

class MyPiece < Piece
  All_My_Pieces = [
  	[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]),#Z
  			  rotations([[0, 0], [1, -1], [0, 1], [1, 0], [1, 1]]), #5blob
               [[[0,0],[0,-2],[0,-1],[0,1],[0,2]],
              [[0,0],[-2,0],[-1,0],[1,0],[2,0]]],
               rotations([[0,0],[0,1],[1,0]])
           ]
    
    Cheated_Piece = [[[0,0]]]

  def self.next_piece (board)
  	Piece.new(All_My_Pieces.sample, board)
  end

  def self.cheated (board)
  	Piece.new(Cheated_Piece, board)
  end
end

class MyBoard < Board
    def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @cheated = false
  	end

	def rotate_180degrees
	    if !game_over? and @game.is_running?
	      @current_block.move(0, 0, 2)
	    end
	    draw
	end

    def next_piece
		super()
		if cheated
			@current_block = MyPiece.cheated(self) 
			@cheated = false
		else
			@current_block = MyPiece.next_piece(self) 
		end
	end

	def cheat
		if !cheated && score >=100
			@score -= 100
			@cheated = true
		end
	end

	def cheated
		@cheated
	end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..locations.size-1).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end

class MyTetris < Tetris
    def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
  	super()
  	@root.bind('u', proc {@board.rotate_180degrees})
  	@root.bind('c', proc {@board.cheat})
  end
end


