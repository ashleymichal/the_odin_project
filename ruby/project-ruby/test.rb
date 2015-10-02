module PigLatin

  def translate phrase
    if phrase.split.length > 1
      new_phrase = []
      phrase.split.each do |i|
        new_phrase << translate(i)
      end
      return new_phrase.join(' ')
    end
    while is_consonant(phrase[0])
      if phrase[0..1] == "qu"
        phrase = phrase[2..-1] + phrase[0..1]
        next
      end
      phrase = phrase[1..-1] + phrase[0]
    end
    return phrase + 'ay'
  end

  def is_consonant (char)
    !'aeiou'.include?(char)
  end

end

class Book
  attr_accessor :title

  def initialize
    @title = ""
  end

  def title
    conjunctions = ['and','or','but']
    prepositions = ['in', 'of']
    articles = ['a','an','the']
    show_title = []
    @title.split.each do |i|
      if !conjunctions.include?(i) && !articles.include?(i) && !prepositions.include?(i)
        show_title << i.capitalize
      else
        show_title << i
      end
    end
    show_title[0] = show_title[0].capitalize
    show_title.join(' ')
  end
  
end

class Timer
  
  attr_accessor :seconds
  def initialize
    @seconds = 0
    @minutes = @seconds/60
    @hours = @minutes/60
  end
  
  def seconds
    @seconds
  end
  
  def minutes
    @minutes
  end
  
  def hours
    @hours
  end
  
  def time_string
    "#{format('%02d', @hours)}:#{format('%02d', @minutes)}:#{format('%02d', @seconds)}"
  end

end