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
    page = "#{$!}"
  end
  response = "HTTP/1.0 #{status} #{message}
             "
  return response + page
end
  

loop {
  client = server.accept
  client.puts(Time.now.ctime)
  request = client.gets
  header = request.split(" ")
  client.puts response(header[1]) if header[0] == 'GET'
  client.puts "Closing the connection. Bye!"
  client.close
}