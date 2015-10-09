require 'socket'
require 'json'
require 'erb'

# returns hash of header information
def parse_headers(request_headers)
  header_lines = request_headers.split("\r\n")
  request_type, path, version = header_lines[0].split(" ")
  headers = {"request_type" => request_type,
             "path" => path,
             "version" => version}
  header_lines[1..-1].each do |line|
    key, value = line.split(":", 2)
    headers[key] = value.lstrip
  end
  headers
end

# returns post information
def process_post_request(post_request, path)
  params = JSON.parse(post_request)
  viking = params["viking"]
  name = viking["name"]
  email = viking["email"]
  template_file = File.read(path)
  erb_template = ERB.new template_file
  content = erb_template.result(binding)
  content
end

# returns status, message, and content
def get_content(path, post_request)
  status = '200'
  message = 'OK'
  begin
    if post_request.nil?
      contentfile = File.new(path, 'r')
      content = contentfile.read
    else
      content = process_post_request(post_request, path)
    end
  rescue
    status = '404'
    message = 'File not Found'
    content = "#{$!}"
  end
  [status, message, content]
end

# returns HTTP-compliant response string
def build_response(status, message, content)
  length = content.length
  response = "HTTP/1.0 #{status} #{message}\r\n"\
             "#{Time.new.asctime}\r\n"\
             "Content-Type:   text/html\r\n"\
             "Content-Length: #{length}\r\n\r\n"
  response + content
end

def run_server
  server = TCPServer.open(2000)
  loop {
    client = server.accept
    headers = parse_headers(client.gets("\r\n\r\n"))
    path = headers["path"]
    request_type = headers["request_type"]
    begin
      case request_type
      when "GET"
        post_request = nil
      when "POST"
        length = headers["Content-Length"].to_i
        post_request = client.read(length)
      else
        raise "Unrecognized request type"
      end
      status, message, content = get_content(path, post_request)
      response = build_response(status, message, content)
    rescue
      response = $!
    ensure
      client.puts(response)
      client.puts "Closing the connection. Bye!"
      client.close
    end
  }
end

run_server