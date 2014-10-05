class Hand
  include Comparable
  attr_accessor :value

  def initialize(value)
    @value=value
  end

  # For Comparable
  def <=>(another_hand)
    if @value==another_hand.value
      0
    elsif (@value=='p' && another_hand.value=='r')||(@value=='r'&&another_hand.value=='s')||(@value=='s'&&another_hand.value=='p')
      1
    else
    -1 
    end


  end #end of def compare

    def to_s
      "I am #{self.value}"
    end
      
end #end of class


class Player
  attr_reader :name
  attr_accessor :choice, :hand
  #attr_reader :hand
  def initialize (n)
    @name=n
  end

  def to_s
    "#{self.name} currently have a choice of #{self.hand.value}"
  end


end

#=====================================

class Human < Player
  def pick_hand
    begin
      puts "Please pick one ( p , r , s )"
      c=gets.chomp.downcase
    end until Game::CHOICES.keys.include? c
    self.hand=Hand.new(c)
  end
end

#===================================== 
class Computer < Player
  def pick_hand
    self.hand=Hand.new(Game::CHOICES.keys.sample)
  end
end


#========================================

class Game
  attr_reader :player,:computer
  CHOICES={'p'=>'Paper','r' =>'Rock','s'=>'Scissors'}

  def initialize
    @player=Human.new("Bob")
    @computer=Computer.new("RD202")
  end

  def compare
    if player.hand==computer.hand
      puts "It is a tie"
    elsif player.hand>computer.hand
      puts "Player win"
    else
      puts "Computer win"
    end

        
    
  end

  def play
    player.pick_hand
    computer.pick_hand


    compare
    puts player.hand
    puts computer.hand
  end

end

game=Game.new.play