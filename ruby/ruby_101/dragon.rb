class Dragon
  
  def initialize name
    @name = name
    @asleep = false
    @stuffInBelly     = 10
    @stuffInIntestine = 0
    
    puts @name + ' is born.'
  end
  
  def feed
    puts 'You feed ' + @name + '.'
    @stuffInBelly = 10
    passageOfTime
  end
  
  def walk
    puts 'You walk ' + @name + '.'
    @stuffInIntestin = 0
    passageOfTime
  end
  
  def putToBed
    puts 'You put ' + @name + ' to bed.'
    @asleep = true
    3.times do
      if @asleep
        passageOfTime
      end
      if @asleep
        puts @name + ' snores, filling the room with smoke.'
      end
    end
    if @asleep
      @asleep = false
      puts @name + ' wakes up slowly.'
    end
  end
  
  def toss
    puts 'You toss ' + @name + ' up into the air.'
    puts 'He giggles, which singes your eyebrows.'
    passageOfTime
  end
  
  def rock
    puts 'You rock ' + @name + ' gently.'
    @asleep = true
    puts 'He briefly dozes off...'
    passageOfTime
    if @asleep
      @asleep = false
      puts '...but wakes when you stop.'
    end
  end
  
  private
  
  def hungry?
    @stuffInBelly <= 2
  end
  
  def poopy?
    @stuffInIntestine >= 8
  end
  
  def passageOfTime
    if @stuffInBelly > 0
      @stuffInBelly     = @stuffInBelly    - 1
      @stuffInIntestine = @stuffInIntestine + 1
    else
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts @name + ' is starving!  In desperation, he ate YOU!'
      exit
    end
    
    if @stuffInIntestine >= 10
      @stuffInIntestine = 0
      puts 'Whoops! ' + @name + ' had an accident...'
    end
    
    if hungry?
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts @name + '\'s stomach grumbles...'
    end
    
    if poopy?
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts @name + ' does the potty dance...'
    end
  end
end

def playWithDragon
  puts "Your new dragon just hatched from its egg!"
  puts "He looks at you with happy (but hungry) eyes."
  puts "What will you call him?"
  name = gets.chomp.upcase
  puts "That's a great name!"
  pet = Dragon.new name
  input = ''
  while input != 'QUIT'
    puts "What would you like to do with " + name + "?"
    puts "Enter FEED, WALK, TOSS, ROCK or put to BED"
    puts "Enter QUIT to quit"
    input = gets.chomp.upcase
    puts input
    if input == "FEED"
      pet.feed
    elsif input == "WALK"
      pet.walk
    elsif input == "BED"
      pet.putToBed
    elsif input == "TOSS"
      pet.toss
    elsif input == "ROCK"
      pet.rock
    end
  end
  exit
end

playWithDragon