require 'socket'
require 'json'
require 'erb'

$host = 'localhost'                      # The web server
$port = 2000                             # Default HTTP port
$get_path = "./index.html"
$post_path = "./thanks.erb"

# returns a json-formatted string representing a hash
def build_post_content
  viking = Hash.new
  puts "Welcome Viking! Please enter your info to register for the upcoming raid."
  print "Name: "
  viking["name"] = gets.chomp
  print "Email: "
  viking["email"] = gets.chomp
  {"viking" => viking}.to_json
end

# returns an HTTP-compliant (hopefully) request string
def build_request(request_type, path, post_content)
  request  = "#{request_type} #{path} HTTP/1.0\r\n"\
             "From: ashleymichal@gmail.com\r\n"\
             "User-Agent: HTTPTool/1.0\r\n"
  content = ""
  if request_type == "POST"
    content_length = post_content.length
    content = post_content
    # determine content_type, content_length
    request += "Content-Type:   JSON\r\n"\
               "Content-Length: #{content_length}\r\n"\
  end
  [request, content].join("\r\n")
end

# connects to server, submits request, returns response from server
def make_request(request)
  socket = TCPSocket.open($host,$port)
  socket.print(request)
  socket.read
end

# returns either error message or page content from server
def read_response(response)
  headers,body = response.split("\r\n\r\n", 2)
  http,status,message = headers.split(" ", 3)
  case status
  when '200'
    return body
  else
    return "#{status} - #{message}"
  end
end

def start_browser
  loop {
    begin
      print "Is this a GET or POST request?  "
      request_type = gets.chomp.upcase
      case request_type
      when 'POST'
        post_content = build_post_content
        path = $post_path
      when 'GET'
        post_content = nil
        path = $get_path
      when 'Q'
        exit
      else
        raise "Unrecognized request type."
      end
      request = build_request(request_type, path, post_content)
      response = make_request(request)
      # puts response
      page = read_response(response)
      puts page
    rescue
      puts $!
      retry
    end
  }
end

start_browser