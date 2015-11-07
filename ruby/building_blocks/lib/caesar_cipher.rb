def caesar_cipher(message, shift=0)
  new_message = ""
  message.chars do |letter|
    case
    when letter =~ /[A-Z]/
      shifted = ((letter.ord + shift - 'A'.ord) % 26 + 'A'.ord).chr
    when letter =~ /[a-z]/
      shifted = ((letter.ord + shift - 'a'.ord) % 26 + 'a'.ord).chr
    else
      shifted = letter
    end
    new_message << shifted
  end
  new_message
end      

if __FILE__ == $0
  puts caesar_cipher("What a string!", 5)
end