class Array
  def eachEven(&wasABlock_nowAProc)
    isEven = true
    
    self.each do |object|
      if isEven
        wasABlock_nowAProc.call object
      end
      
      isEven = (not isEven)
      
    end
  end
end

['apple', 'bad apple', 'cherry', 'durian'].eachEven do |fruit|
  puts 'Yum!  I just love ' + fruit + ' pies, don\'t you?'
end

[1, 2, 3, 4, 5].eachEven do |oddBall|
  puts oddBall.to_s+' is NOT an even number!'
end