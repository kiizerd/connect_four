class Player

  def make_move
    puts "Enter your move"
    response = gets.chomp
    until check_move(response)
      puts "Error, try again"
      response = gets.chomp
    end
    response
  end

  def check_move(move)
    ary = move.split('')
    first = ary[0].to_i != 0
    second = ary[-1].to_i != 0
    middle_mid = ary[1] == '-'
    if ary.first.to_i > 7 or ary.first.to_i < 1
      in_range = false
    elsif ary.last.to_i > 7 or ary.last.to_i < 1
      in_range = false
    else
      in_range = true
    end
    if first and second and middle_mid and in_range
      return true
    else
      return false
    end
  end

end
