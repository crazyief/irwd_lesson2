require "pry"
class Board 
  attr_accessor :data

  # Initialize with Square array created 
  def initialize 
    @data={}
    (1..9).each {|position|
      @data[position] = Square.new(" ")
    }
  end

  def winning_condition?(marker)
    condition=false

    if ((@data[1].marker==marker) and (@data[2].marker==marker) and (@data[3].marker==marker)) ||
      ((@data[4].marker==marker) and (@data[5].marker==marker) and (@data[6].marker==marker)) ||
      ((@data[7].marker==marker) and (@data[8].marker==marker) and (@data[9].marker==marker)) ||
      ((@data[1].marker==marker) and (@data[4].marker==marker) and (@data[7].marker==marker))||
      ((@data[2].marker==marker) and (@data[5].marker==marker) and (@data[8].marker==marker))||
      ((@data[3].marker==marker) and (@data[6].marker==marker) and (@data[9].marker==marker))||
      ((@data[1].marker==marker) and (@data[5].marker==marker) and (@data[9].marker==marker))||
      ((@data[3].marker==marker) and (@data[5].marker==marker) and (@data[7].marker==marker))
      condition=true
    end

    return condition

  end

  def empty_squares
    self.data.select {|key,square| square.marker==" "}.values
  end

  def empty_position
    self.data.select {|key,square| square.empty?}.keys  
  end

  def squares_empty?
    self.empty_squares.size==0
  end

  def mark_square(position,marker) 
    @data[position].marker=marker
  end

  def draw
    puts "Board drawing"
    system "clear"

    puts "     |     |      "
    puts "  #{self.data[1].marker}  |  #{self.data[2].marker}  |  #{self.data[3].marker}  "
    puts "     |     |      "
    puts "-----+-----+-----"
    puts "     |     |      "
    puts "  #{self.data[4].marker}  |  #{self.data[5].marker}  |  #{self.data[6].marker}  "
    puts "     |     |      "
    puts "-----+-----+-----"
    puts "     |     |      "
    puts "  #{self.data[7].marker}  |  #{self.data[8].marker}  |  #{self.data[9].marker}  "
    puts "     |     |      "
  end
end  # end of board class

  



class Player 
  attr_accessor :name , :marker
  def initialize(name,marker)
    @name=name
    @marker=marker
  end
end #end of player




class Square 
  attr_accessor :marker
  def initialize(marker)
    @marker=marker
  end

  def to_s
    puts self.marker
  end

  def occupied?
    self.marker !=" "
  end

  def empty?
    self.marker==" "
  end

end# end of Square 



class Game

  def initialize
    @the_board=Board.new
    @human=Player.new("Bob","X")
    @computer=Player.new("R202","O")
    @currently_player=@human
  end

  def currently_player_mark_square 
    if @currently_player==@human
      begin
        puts "Choose from the position plz , 1 to 9"
        position=gets.chomp.to_i
      end until @the_board.empty_position.include? position
    else
      position=@the_board.empty_position.sample
    end# end of if 
    
    marker=@currently_player.marker
    @the_board.mark_square(position,marker) #if @the_board.squares_empty?
    #puts "No more space !" if !@the_board.squares_empty?
  end # end of player mark square

  def change_player
    if @currently_player==@human
      @currently_player=@computer
    else
      @currently_player=@human
    end #end of if 
  end # end of change player

  def currently_player_wins?
    @the_board.winning_condition?(@currently_player.marker)
  end

  def play
    @the_board.draw
    loop do
      currently_player_mark_square
      
      @the_board.draw

      if currently_player_wins?
        puts "We get a winner #{@currently_player.name}"
        break
      elsif @the_board.squares_empty?
        puts "it is a tie"
        break
      else
        change_player
      end

      #binding.pry


    end #end of loop
    puts "Bye"
  end #end of play method

end # end of the game

the_game=Game.new
the_game.play