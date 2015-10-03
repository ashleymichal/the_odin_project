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
  header = header.split(" ")
  client.puts response(header[1]) if header[0] == 'GET'
  client.puts "Closing the connection. Bye!"
  client.close
}