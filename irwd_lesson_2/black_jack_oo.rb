require 'pry'
class Player
  attr_accessor :name,:hand
  def initialize(name)
    @name=name
    @hand=[]
  end

  def get_hand_points
    hand_points=0
    @hand.each do |x|
      hand_points=hand_points+x.point.to_i
    end
    hand_points   
  end # end of method 
end #end of Class

class House < Player
end

class Punter <Player
end


class Deck
  attr_accessor :cards
  def initialize
    @cards=[]
    deck_color=%w(Spade Club Heart Square)
    rank_point=%w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
    array_of_cards=deck_color.product rank_point
    array_of_cards.each {|card| 
      card << "Down"
      @cards << Card.new(card[0],card[1],card[2])
    }
  end # end of Initialize 
end # end of Class


class Card
  attr_accessor :color,:number,:face,:point
  def initialize(color,number,face="Down")
    @color=color
    @number=number
    @face=face
    get_card_point
  end

  def get_card_point
    if @face=="Up"
     case self.number
      when "1"
        self.point=1
      when "2"
        self.point=2
      when "3"
        self.point=3
       when "4"
        self.point=4
      when "5"
        self.point=5
      when "6"
        self.point=6
      when "7"
        self.point=7
      when "8"
        self.point=8
      when "9"
        self.point=9
      when "10"
        self.point=10
      when "Jack"
        self.point=10
      when "Queen"
        self.point=10
      when "King"
        self.point=10
      when "Ace"
        self.point=11
      end     
    end
  end #end of Method

  def to_s
    "#{self.color} , #{self.point} ,#{self.face}"
  end
end # end of Card Class

class Game
  HOUSE_MIN_POINT=17
  BOTH_MAX_POINT=21

  def initialize
    deck=Deck.new()
    punter=Player.new("Bob")
    house=Player.new("House")
    deck.cards.shuffle! #<== Shuffle the deck 
  end

  def play
    # deal_first_2_cards
    # currently_player=punter
    #loop do
    #   deal_card
    #   check_win_condition
    #   change_currently_player
    #end <==break if someone busted 
    #puts "Bye"
    #

  end

  def deal_first_2_cards
    #
  end

  def deal_card
    #
  end


end #end of CLASS

the_game=Game.new

the_game.play







