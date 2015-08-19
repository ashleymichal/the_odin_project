def caesar_cipher(message, shift)
  shift = shift % 26
  new_message = ""
  message.each_byte do |letter|
    # non-alpha values - this could probably be better
    if letter < 'A'.ord || ('Z'.ord < letter && letter < 'a'.ord) || letter > 'z'.ord
      new_letter = letter
    elsif letter < 'Z'.ord   # is uppercase
      new_letter = (letter + shift - 'A'.ord) % 26 + 'A'.ord
    else letter < 'z'.ord   # is lowercase
      new_letter = (letter + shift - 'a'.ord) % 26 + 'a'.ord
    end
    new_message += new_letter.chr
  end
  new_message
end

## not super proud of this one... needs refactoring and better design. also it doesn't work.  ballz.

puts caesar_cipher("What a string!", 5)