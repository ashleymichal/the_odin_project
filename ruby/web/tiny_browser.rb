require 'socket'
require '/httparse'

$host = 'localhost'                      # The web server
$port = 2000                             # Default HTTP port
$path = "/Users/ashleymichal/Sites/the_odin_project/ruby/web/index.html"                    # The file we want

# takes the request
def build_request(type, info="")
  request = "#{type} #{$path} HTTP/1.0\r\n\r\n"
end

def make_request(request)
  socket = TCPSocket.open($host,$port)    # Connect to server
  socket.print(request)                   # Send request
  return socket.read                      # Read complete response
end

def render_response(response)
  headers,body = response.split("\r\n\r\n", 2)
  http,status,message = headers.split(" ", 3)
  case status
  when '200'
    return body.                          # And display it
  when '404'
    return "#{status} - #{message}"
  else
    return body
  end
end

def get_post_info
  return "POST"
end

loop {
  begin
    print "Is this a GET or POST request?  "
    type = gets.chomp.upcase
    case type
    when 'GET'
      request = build_request(type)
      response = make_request(request)
      page = render_response(response)
      puts page
    when 'POST'
      request = "#{type} #{$path} HTTP/1.0\r\n\r\nshenanigans\n"
      response = make_request(request)
      puts response
      # puts "making new request"
      # new_response = make_request("shenanigans\n")
      # puts new_response
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

socket = TCPSocket.open(host,port)      # Connect to server
socket.print(request)                   # Send request
response = socket.read                  # Read complete response
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
http,status,message = headers.split(" ", 3)
case status
when '200'
  print body                            # And display it
else
  puts "#{status} - #{message}"
end
