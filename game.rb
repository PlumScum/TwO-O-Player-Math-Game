require "./player"
require "./questions"

class Game
  def initialize
    @player1 = Player.new('Player 1')
    @player2 = Player.new('Player 2')
    @current_player = @player2
  end

  def players_alive?
    @player1.lives > 0 && @player2.lives > 0
  end

  def game_condition
    if players_alive?
      puts "P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3"
      puts "\n----- NEW TURN -----\n"
    else
      switch_players
      puts "\n----- GAME OVER -----\n"
      puts "#{@current_player.name} wins with a score of #{@current_player.lives}/3"
    end
  end

  def switch_players
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def correct?
    while players_alive?
      switch_players
      new_question = Question.new
      puts "#{@current_player.name}: #{new_question.new_question}"
      answer = $stdin.gets.chomp.to_i
      
      if answer == new_question.solution
        puts "#{@current_player.name}: Smooth Job!!"
        game_condition
      else
        puts "#{@current_player.name}: Oh no! Hope you'll do better next round!"
        @current_player.lives -= 1
        game_condition
      end
    end
  end
end

# Uncomment the lines below to run the game
# game = Game.new
# game.correct
