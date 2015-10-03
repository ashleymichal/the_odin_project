require 'socket'

$host = 'localhost'                      # The web server
$port = 2000                             # Default HTTP port
$path = "/Users/ashleymichal/Sites/the_odin_project/ruby/web/index.html"                    # The file we want

# This is the HTTP request we send to fetch a file
# request = "GET #{$path} HTTP/1.0\r\n\r\n"

def build_request(type, info="")
  request = "#{type} #{$path} HTTP/1.0\r\n\r\n" + info
  request
end

def make_request(request)
  socket = TCPSocket.open($host,$port)    # Connect to server
  socket.print(request)                   # Send request
  return socket.read                    # Read complete response
end

  # Split response at first blank line into headers and body
def render_response(response)
  headers,body = response.split("\r\n\r\n", 2)
  http,status,message = headers.split(" ", 3)
  case status
  when '200'
    return body                            # And display it
  when '404'
    return "#{status} - #{message}"
  else
    return body
  end
end

def get_post_info
  puts "then you would get post info"
  return nil
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
      post_info = get_post_info
      request = build_request(type, post_info)
      response = make_request(request)
      page = render_response(response)
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
