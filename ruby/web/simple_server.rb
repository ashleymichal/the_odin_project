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
<<<<<<< HEAD
  header,body = request.split("\r\n\r\n")
  type,path,version = header.split(" ")[0..3]
  case type
  when 'GET'
    client.puts response(path)
  when 'POST'
    client.puts header
  else
    client.puts "Unrecognized request"
  end
=======
  header = request.split(" ")
  client.puts response(header[1]) if header[0] == 'GET'
>>>>>>> parent of c98c188... stage two: adding support for POST requests
  client.puts "Closing the connection. Bye!"
  client.close
}