require 'socket'
require 'json'

$host = 'localhost'                      # The web server
$port = 2000                             # Default HTTP port
$path = "/Users/ashleymichal/Sites/the_odin_project/ruby/web/index.html"                    # The file we want

# This is the HTTP request we send to fetch a file

def build_request(type, info=nil)
  request = "#{type} #{$path} HTTP/1.0\r\n\r\n"
  return request + info unless info.nil?
  request
end

def make_request(request)
  socket = TCPSocket.open($host,$port)      # Connect to server
  socket.print(request)                   # Send request
  response = socket.read                  # Read complete response
  # Split response at first blank line into headers and body
  headers,body = response.split("\r\n\r\n", 2)
  http,status,message = headers.split(" ", 3)
  case status
  when '200'
    return body                            # And display it
  when '404'
    return "#{status} - #{message}"
  else
    return response
  end
end

def get_post_info
  puts "Welcome, Viking! Please enter your Raid Registration Information"
  print "Name:  "
  name = gets.chomp
  print "Email: "
  email = gets.chomp
  viking = { :viking => { :name => name, :email => email } }
  return viking.to_json
end

loop {
  begin
    print "Is this a GET or POST request?  "
    type = gets.chomp.upcase
    case type
    when 'GET'
      request = build_request(type)
      page = make_request(request)
      puts page
    when 'POST'
      post_info = get_post_info
      request = build_request(type, post_info)
      response = make_request(request)
      puts response
    when 'Q'
      exit
    else
      raise "Unrecognized request type."
    end
  rescue
    puts $!
    retry
  end
}