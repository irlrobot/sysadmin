#!/usr/bin/ruby

def path1
  puts "The path splits left and right.  Which do you choose?"
  path = gets.chomp.downcase

  if (path == "left") || (path == "right")
    case path
    when "left"
      puts "You have been eaten by a pack of rabid wolves. Game Over."
    when "right"
      path2()
    end
  else
    puts "You must specify left or right only.  Try again." 
    path1()
  end
end

def path2
  puts "You see two goblins ahead. Looks like you got the jump on them. Cast a fireball or shoot them with your bow?"
  attack = gets.chomp.downcase

  if (attack == "fireball") || (attack == "bow")
    case attack
    when "fireball"
      puts "Oh no, Goblins are immune to fire!  Game Over."
    when "bow"
      puts "Nice shot!  The Goblins are dead."
      path3()
    end
  else
    puts "You must specify 'fireball' or 'bow' only.  Try again."
    path2()
  end
end

def path3
  puts "Up ahead is a river.  Try to cross it?"
  river = gets.chomp.downcase

  case river
  when "yes", "y"
    puts "You make it across the river with little issue."
    path4a()
  when "no", "n"
    puts "You continue down the path following the river North."
    path4b()
  else
    puts "You must specify 'yes' or 'no'.  Try again."
    path3()
  end
end

def path4a
  puts "You continue and find a Cyclops, uh oh!  Will you:"
  puts "A) Run"
  puts "B) Attack with sword"
  puts "C) Attack with lightning bolt"
  attack = gets.chomp.downcase
end

def path4b
  puts "place holder"
end

path1()
