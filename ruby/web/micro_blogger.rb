require 'jumpstart_auth'
require 'bitly'
Bitly.use_api_version_3

class MicroBlogger
  attr_reader :client
  
  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end
  
  def tweet(message)
    begin
      if message.length <= 140
        @client.update(message)
      else
        raise "message too long"
      end
    rescue
      puts $!
    end
  end
  
  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
    begin
      screen_names = followers_list
      if screen_names.include?(target)    
        message = "d @#{target} #{message}"
        tweet(message)
      else
        raise "You can only direct message your followers"
      end
    rescue
      puts $!
    end
  end
  
  def spam_my_followers(message)
    followers_list.each do |follower|
      dm(follower, message)
    end
  end
  
  def followers_list
    @client.followers.collect { |follower| @client.user(follower).screen_name }
  end
  
  def everyones_last_tweet
    friends = @client.friends.collect { |friend| @client.user(friend) }
    friends.sort_by! { |friend| friend.screen_name.downcase }
    friends.each do |friend|
      # find each friend's last message
      timestamp = friend.status.created_at
      puts "#{friend.screen_name}"
      puts "#{friend.status.text}"
      puts timestamp.strftime("%A, %b %d")
    end
  end
  
  def shorten(original_url)
    # Shortening Code
    puts "Shortening this URL: #{original_url}"
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    return bitly.shorten(original_url).short_url
  end
  
  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'spam' then spam_my_followers(parts[1..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 's' then shorten(parts[1])
        when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end
end

blogger = MicroBlogger.new
blogger.run