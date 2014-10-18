require 'pry'

class Player
  attr_accessor :name,:hand
  def initialize(name)
    @name=name
    @hand=[]
  end

  def get_hand_points
    hand_points=0
    ace_count=0
    @hand.each do |card|
      hand_points=hand_points+card.point.to_i
      ace_count=ace_count+1 if card.number=="Ace"
      ace_count.times {
          hand_points=hand_points-10 if hand_points>Game::BOTH_MAX_POINT
        }
    end
    hand_points   
  end # end of method 
end #end of Class
#====================
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
#=====================================================
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
    "#{self.color} of #{self.number}"
  end
end # end of Card Class
#========================================================
class Game
  attr_accessor :punter,:house,:deck,:currently_player
  HOUSE_MIN_POINT=17
  BOTH_MAX_POINT=21

  def initialize
    @deck=Deck.new()
    @punter=Player.new("Bob")
    @house=Player.new("House")
    @deck.cards.shuffle! #<== Shuffle the deck 
  end
#==========PLAY================
  def play
    system("clear")
    self.currently_player=@punter
    deal_first_2_cards   # for both player , roate currently_player

    puts "House have  >>#{house.hand[0]}<<  with another face down card now "
    puts "Punter #{punter.name} have 2 cards >> #{punter.hand[0]} <<    >>#{punter.hand[1]}<<"

    begin
      try_deal_card_to_player   # deal to both   Punter and House 
    end until  punter.get_hand_points>BOTH_MAX_POINT or house.get_hand_points>HOUSE_MIN_POINT #end of loop

    decide_winner
  end # END OF PLAY 
#===============
  def decide_winner
    puts "#{punter.name} get #{punter.get_hand_points}"
    puts "#{house.name} get #{house.get_hand_points}"

    if punter.get_hand_points<=BOTH_MAX_POINT and house.get_hand_points<=BOTH_MAX_POINT
      if punter.get_hand_points>house.get_hand_points
        puts "Punter #{punter.name} win"
      elsif punter.get_hand_points==house.get_hand_points
        puts "Draw"
      else
        puts "House win"
      end
    elsif punter.get_hand_points<=BOTH_MAX_POINT and house.get_hand_points>BOTH_MAX_POINT
      puts "Punter #{punter.name} win"
    elsif punter.get_hand_points>BOTH_MAX_POINT
      puts "House win"
    end
  end

  def try_deal_card_to_player
    #========current player is Punter   Deal the Card==========
    if self.currently_player==punter 
      ask_punter_for_cards
    else 
      # =======current player is House    Deal the card ============
      case currently_player.get_hand_points
      when 1..17
        #puts "House need more card "
        deal_card
        puts "Busted , #{self.currently_player.name} get #{currently_player.get_hand_points}" if currently_player.get_hand_points>21
      when 18..21
        puts "House is in his safe range now"
      else
        puts "House busted"
      end
    end # end of if
  end # end of Method 
#=============================
  def ask_punter_for_cards
    puts "#{currently_player.name} you have #{currently_player.get_hand_points}"
    puts "Do you need more card ?"
    answer=gets.chomp
    if answer=="y" || answer=="yes"
      deal_card
      puts "Busted , #{self.currently_player.name} get #{currently_player.get_hand_points}" if currently_player.get_hand_points>21
    else # player say NO for deal card 
      self.currently_player=house
      turn_over_house_down_card
    end # end of if 

    # Ask the punter if they need a card again , loop this method itseld 
    ask_punter_for_cards if (self.currently_player ==punter) and punter.get_hand_points< BOTH_MAX_POINT
  end

  def turn_over_house_down_card
      currently_player.hand[1].face="Up"
      currently_player.hand[1].get_card_point
      currently_player.get_hand_points
      puts "House turn over a #{currently_player.hand[1]}"
  end

  def deal_first_2_cards
    self.currently_player=punter
    deal_card
    deal_card

    self.currently_player=house
    deal_card
    deal_card_with_face_down

    self.currently_player=punter
  end

  def deal_card
    new_card=deck.cards.pop
    new_card.face="Up"
    new_card.get_card_point
    self.currently_player.hand << new_card
    puts "Dealer deal a #{new_card} to #{currently_player.name}"
  end

  def deal_card_with_face_down
    new_card=deck.cards.pop
    new_card.face="Down"
    new_card.get_card_point
    self.currently_player.hand << new_card
  end

end #end of GAME CLASS

the_game=Game.new
the_game.play