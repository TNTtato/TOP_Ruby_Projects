class Game
  def initialize
    @remaining_attempts = 12
    # instructions needed, must be created in interface
    choose_role
  end

  def choose_role
    loop do
      puts 'choose your role:'
      puts 'BREAKER ----> 1'
      puts 'GUESSER ----> 2'
      @role = gets.chomp.to_i
      break if (1..2).include? @role
    end
  end
end