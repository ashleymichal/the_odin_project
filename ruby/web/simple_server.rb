require 'socket'

server = TCPServer.open(2000)

def response(address)
  status = '200'
  message = 'OK'
  begin
    page = ""
    pagefile = File.new(address, 'r')
    page = pagefile.readlines.join("\n")
  rescue
    status = '404'
    message = 'File Not Found'
  end
  response = "HTTP/1.0 #{status} #{message}\r\n\r\n"
  response + page unless page.nil?
end
  

loop {
  client = server.accept
  request = client.gets
  header,body = request.split("\r\n\r\n")
  type,path,version = header.split(" ")[0..3]
  case type
  when 'GET'
    client.puts response(path)
  when 'POST'
    client.puts "Received POST request"
  else
    client.puts "Unrecognized request"
  end
  client.puts "Closing the connection. Bye!"
  client.close
}