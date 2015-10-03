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
  client.puts request
  # header,body = request.split("\r\n\r\n")
  # header = header.split(" ")
  # case header[0]
  # when 'GET'
  #   client.puts response(header[1]) + body.to_s
  # when 'POST'
  #   client.puts request
  # end 
  client.puts "Closing the connection. Bye!"
  client.close
}