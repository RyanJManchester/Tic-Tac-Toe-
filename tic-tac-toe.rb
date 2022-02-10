# tic-tac-toe game
# class defines the board operations
class TicTacToe
  def initialize
    @slots = Array.new(3) { Array.new(3, ' ') }
    place_board
    greet
    @not_won = true
  end

  def place_board
    puts @slots[0].join('|')
    puts @slots[1].join('|')
    puts @slots[2].join('|')
  end
  attr_accessor :slots, :not_won, :first

  def play(player1,player2)
    @first = player1.first
    @first == 'X'? player2.identity = '0': player2.identity = 'X'
    continue(player1,player2)
  end
  protected

  def greet
    puts 'Hello! Welcome to tic-tac toe'
  end

  def playing(player)
    if @not_won == false
    p
    else
      place_board
      puts "#{player.name}, Enter the row then column you want to select:"
      puts "Row:"
      row = gets.chomp.to_i - 1
      puts 'Column:'
      column = gets.chomp.to_i - 1
      if slots[row][column].include?(' ')
        slots[row][column] = player.identity.to_s
        puts "#{player.name} entered at #{row + 1}, #{column + 1}."
      else
        puts "#{player.name}, it must be a empty spot!"
        playing(player)
      end
    end
    
  end

  def continue(player1,player2)
    while @not_won == true
      if @first == 1
        playing(player1)
        @first = 2
      else
        playing(player2)
        @first = 1
      end
    check(slots,[player1,player2])
    end
  end

  def check(slots,playerarray)
    playerarray.each do |player|
      val = player.identity
      for i in 0..2
        if slots[i].all? { |x| x == val}
        won(player)
        end
        result = []
        for j in 0..2
          result << slots[j][i]
        end
        if result.all? { |x| x == val}
        won(player)
        end
      end
      if slots[1][1] == val
        if (slots[0][0] == val) && (slots[2][2] == val)
          won(player)
        elsif (slots[2][0] == val) && (slots[0][2] == val)
          won(player)
        end
      end
    end
  end

  def won(player)
    @not_won = false
    puts "#{player.name} has won the game!"
    puts 'Would you like to play again? enter Y'
    if gets.chomp.upcase == 'Y'
      slots = Array.new(3) {Array.new(3, ' ') }
      @not_won = true
      one = Player.new
      two = Player.new
      self.play(one,two)
    else
      puts "quitting"
      sleep 3
    end
  end

end

# Player Class
class Player
  @@count = 1
  def initialize
    puts "Enter player#{@@count}'s name:"
    name = gets.chomp
    @name = name
    @@count > 2? @@count = 1: @@count + 1
  end

  def first
    puts "Would #{name} like to go first?
    the first player will be X: Y / N"
    result = gets.chomp
    goes_first(result,name)
  end

  attr_accessor :name, :identity, :result

  protected

  def goes_first(input,name)
    @result = input.downcase
    if @result == 'y'
      @result = self
      @identity = 'X'
    else
      @result = 2
      @identity = '0'
    end
  end

end

game = TicTacToe.new
player1 = Player.new
player2 = Player.new
game.play(player1,player2)