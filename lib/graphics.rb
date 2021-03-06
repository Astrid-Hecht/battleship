class Graphics
  def initialize; end

  def menu_screen
    clear_screen
    puts "        888             888   888   888                888     d8b\n        888             888   888   888                888     Y8P\n        888             888   888   888                888\n        88888b.  8888b. 888888888888888 .d88b. .d8888b 88888b. 88888888b.\n        888 '88b    '88b888   888   888d8P  Y8b88K     888 '88b888888 '88b\n        888  888.d888888888   888   88888888888'Y8888b.888  888888888  888\n        888 d88P888  888Y88b. Y88b. 888Y8b.         X88888  888888888 d88P\n        88888P' 'Y888888 'Y888 'Y888888 'Y8888  88888P'888  88888888888P'\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-888-=-=-=-=-=-\n                                                                  888"
    puts "P: Play with default settings.                                    888\nC: Play custom game.\nQ: Quit. \n>..."
  end

  def quit_screen
    puts "\n\n\n\n\n\n\n      +-------------------------+\n      ||||||     Bye!!     ||||||\n      +-------------------------+\n\n\n\n\n\n\n"
  end

  def customize_board_screen
    puts "\n\n+-----------------------------+\n|       Customize Board       |\n+-----------------------------+\n\n"
    input('Enter board side size (default = 4, min = 2, max = 9):')
  end

  def customize_ships_screen
    puts "\n\n+-----------------------------+\n|       Customize Ships       |\n+-----------------------------+\n\n"
  end

  def input(text)
    puts "\n\n\n\n\n\n#{text}\n\n\n>..."
  end

  def clear_screen
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
  end

  def place_phase(board) 
    puts "\n\n\n\n\n\nI have laid out my ships on the grid.\nYou now need to lay out your #{board.ships.length} ships."
    ship_info = ["The "]
    punct = ", the "
    board.ships.each_with_index do |ship, index|
      punct = ", and the " if index == board.ships.count - 2
      punct = "." if index == board.ships.count - 1
      ship_info << "#{ship.name} is #{ship.length} units long" + punct
      if index % 3 == 0 && index > 0
        ship_info << "\n"
      end
    end
    puts ship_info.join + "\n\n"
  end

  def computer_shoot_anim(show = true)
    return if show == false
    clear_screen
    puts "\n\n\n***************************\n       COMPUTER TURN\n***************************\n\n\n\n\n\n\n"
    sleep(1.5)

  end

  def hit_anim(name = 'destroyer')
    hit_anim = [
      "             |\\**/|\n             \\ == /\n              |  |\n              |  |\n              \\  /\n               \\/", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n"
    ]
    sub = "~~~~~~~~~~~~~~|_~~~~~~~~~~~~~~~~~\n         _____|~ |____ \n       (  --         ~~~~--_, \n        ~~~~~~~~~~~~~~~~~~~'`"
    ship = "                                  # #  ( )\n                               ___#_#___|__\n                           _  |____________|  _\n                    _=====| | |            | | |==== _\n              =====| |.---------------------------. | |====\n<--------------------'   .  .  .  .  .  .  .  .   '--------------/\n  \\                                                             /\n   \\_______________________________________________WWS_________/"
    ship = sub if name.downcase.include?('sub')
    (hit_anim.count - 1).times do
      clear_screen
      puts hit_anim.join
      puts ship
      hit_anim.pop
      sleep(0.1)
    end
    clear_screen
    puts "         _ ._  _ , _ ._\n        (_ ' ( `  )_  .__)\n      ( (  (    )   `)  ) _)\n     (__ (_   (_ . _) _) ,__)\n         `~~`\\ ' . /`~~` \n              ;   ; \n              /` .\\ \n~~~~~~~~~~~~~/, ^  \\~~~~~~~~~~~~~"
    sleep(1)
    clear_screen
    puts "\n\n\n***************************\n          !!HIT!!\n***************************\n\n\n\n\n\n\n"
    sleep(1.5)
  end

  def miss_anim
    hit_anim = [
      "             |\\**/|\n             \\ == /\n              |  |\n              |  |\n              \\  /\n               \\/", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n"
    ]
    wave = ",(   ,(   ,(   ,(   ,(   ,(   ,(   ,(\n  `-'  `-'  `-'  `-'  `-'  `-'  `-'  `-'"
    wave_impact1 = "             |\\**/|\n             \\ == /\n              |  |\n              |  |\n              \\  /\n,(   ,(   ,(   \\/   ,(   ,(   ,(   ,(\n  `-'  `-'  `-'  `-'  `-'  `-'  `-'  `-'\n"
    wave_impact2 = "             |\\**/|\n             \\ == /\n              |  |\n              |  |\n,(   ,(   ,(  \\  /   ,(   ,(   ,(   ,(\n  `-'  `-'  `-'\\/`-'  `-'  `-'  `-'  `-'\n"
    sploosh = "   ,    .  ). (  .  )(. o  . (    ,   '\n'    . o  |.o~ ~~0|   ~ o . | .     .    .\n  .      o |o~ o% .   / % .| o  ,\n      ,     0 % O  | .  o | .\n         o  |  )  0    %  (  .\n             |  o    (.  |\n              |    ,    |\n               ) \   ' (\n ,(   ,(   ,(   )   / (   ,(   ,(   ,(\n   `-'  `-'  `-'       `-'  `-'  `-'  `-'\n"
    (hit_anim.count - 1).times do
      clear_screen
      puts hit_anim.join
      puts wave
      hit_anim.pop
      sleep(0.1)
    end
    clear_screen
    puts wave_impact1
    sleep(0.1)
    clear_screen
    puts wave_impact2
    sleep(0.1)
    clear_screen
    puts sploosh
    sleep(1)
    clear_screen
    puts "\n\n\n***************************\n           MISS\n***************************\n\n\n\n\n\n\n"
    sleep(1.5)
  end

  def sunk_anim
    clear_screen
    puts "\n\n\n***************************\n         SHIP SUNK\n***************************\n\n\n\n\n\n\n"
    sleep(1)
    clear_screen
    puts "       .             `          /\n                       .    ,../...       .\n        .               .  /       `\\  /  .\n  \\    .        o         < '  )     =<\n  /\\  .                    \\ \\      /  \\   .  __\n>=)'>                       `'\\'''''         /o \\/\n  \\/ .    /_        o    /         /,        \\__/\\    .:/\n  /   .  /.-\\ /         /\\        <')=<     .      ,,///;,   ,;/\n         >__/\\         <'(=<                  < 0 ))::::::::;;\\\\\\\n           \\            \\/             .            ''\\\\\\\\\\'' ';\\\n   (                     \\               .   __\n    )                                       <'_><          (\n   (          (                ,/..          `              )\n    )     (    )             <')   `=<                )    (\n    (       )  (               ``\\```                 (      )\n_____)_____(____)______________________________________)____(_______\n"
    sleep(3)
  end

  def play_again
    puts "\n+----------------------------+\n|         GOOD GAME!         |\n+----------------------------+"
    puts "\n\n\nPlay again? [y/n]\n\n\n>..."
  end

end
