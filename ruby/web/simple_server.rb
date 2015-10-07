require 'socket'
require '/httparse'

server = TCPServer.open(2000)

def get_content(address)
  contentfile = File.new(address, 'r')
  content = contentfile.readlines.join("\n")
end

# returns hash of header information
def parse_header(header)
  header_info = {}
  headers = header_info.split("\r\n")
  request_type, path, version = headers[0].split(" ")
  header_info[:request_type => request_type,
              :path => path,
              :version => version]
  headers[1..-1].each do |line|
    key, value = line.split(":", 2)
    header_info[key.to_sym] = value.lstrip
  end
  header_info
end

def get_content(header_info)
  if path == "POST"

    # read remaining headers, looking for
    # => content-type
    # => content-length
    # info = client.gets(Content-Length) (or other method)
    # content = process_post_info(info, path)
  end
end

def process_post_info(info)

end

loop {
  client = server.accept
  header = client.gets("\r\n\r\n")  # returns header
  type, content = parse_header(header)
  case type
  when 'GET'
    get_content(address)
    client.puts response(header[1]) + body.to_s
  when 'POST'
    client.puts request
  end 
  client.puts "Closing the connection. Bye!"
  client.close
}