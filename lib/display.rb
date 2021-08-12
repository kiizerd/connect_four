module Display

  def welcome_screen
    puts title, welcome_prompt
  end

  def title
    <<~'TITLE'

     ___   ___   __  __ __  __  ____   ___ ______     ____   ___   __ __ ____ 
    //    // \\  ||\ || ||\ || ||     //   | || |    ||     // \\  || || || \\
   ((    ((   )) ||\\|| ||\\|| ||==  ((      ||      ||==  ((   )) || || ||_//
    \\__  \\_//  || \|| || \|| ||___  \\__   ||      ||     \\_//  \\_// || \\
                                                                              
                                                                              
    TITLE
  end

  def welcome_prompt
    <<~'WELCOME_PROMPT'

    Welcome to Connect 4 on the terminal, brought to you by Ruby.

    Enter a number between 1 - 3 to get started.

    [1] - Start Game
    [2] - More Info
    [3] - Exit

    WELCOME_PROMPT
  end

  def human_move_prompt min, max
    puts "Enter a number from #{min} - #{max}"
  end

  def show_board graph
    puts `clear`
    graph.each_with_index do |row, i|
      puts "\n" + ("-" * 30)
      row.each_with_index do |node, j|
        print "| #{node} "  if j != 6
        print "| #{node} |" if j == 6
      end
    end
    puts "\n" + ("-" * 30)
  end

  def player_selection_prompt
    <<~PLAYER_SELECTION

    Connect 4 is a two-player game.
    The default play setting in this enviroment is one human player versus one computer player.
    There is also the option to play with 2 human or 2 computer players.
    
    Choose the number of HUMAN players for this game...
    Enter a number from 0 - 2
    [0] - No human players. 2 computers will compete
    [1] - One human player. You will compete against a computer
    [2] - Two human players. 

    PLAYER_SELECTION
  end

  def show_game_over winner
    puts "Game over!!", "#{winner} wins"
    puts game_over_prompt
  end

  def game_over_prompt
    <<~GAME_OVER
    Would you like to keep playing?
    
    [1] - Start new game
    [2] - Exit game
    GAME_OVER
  end

  def more_info
    puts `clear`, show_more_info
    puts "\n", "Press enter to return to main menu"
    gets
    main_menu
  end

  def show_more_info
    <<~MORE_INFO

    Connect 4 is a two-player connection board game, in which the players
    choose a color and then take turns dropping colored discs into a
    seven-column, six-row vertically suspended grid. The pieces fall straight
    down, occupying the lowest available space within the column. The objective
    of the game is to be the first to form a horizontal, vertical, or diagonal
    line of four of one's own discs.
    
    Connect Four is a solved game. The first player can always win by playing the right moves. 

    MORE_INFO
  end
  
end