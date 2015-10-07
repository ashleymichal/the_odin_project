require 'socket'
require '/httparse'

$host = 'localhost'                      # The web server
$port = 2000                             # Default HTTP port
$path = "/Users/ashleymichal/Sites/the_odin_project/ruby/web/index.html"

def build_request(type, path, content="")
  # determine content_type, content_length
  request = "#{type} #{path} HTTP/1.0\n\
            From: #{user_email}\n\
            User-Agent: HTTPTool/1.0\n\
            Content-Type: #{content_type}\n\
            Content-Length: #{content_length}\r\n\r\n\
            \
            #{content}\n"
  return request
end

def make_request(request)
  socket = TCPSocket.open($host,$port)   # Connect to server
  socket.print(request)                  # Send request
  return socket.read                     # Read complete response
end

def get_post_info
  return "POST"
end

loop {
  begin
    print "Is this a GET or POST request?  "
    type = gets.chomp.upcase
    case type
    when 'GET', 'POST'
      request = build_request(type, $path)
      response = make_request(request)
      page = render_response(response)
      puts page
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
