require 'net/http'                  # the library we need
host = 'www.ashleymichal.com'     # The web server
path = "/index.php"                 # The file we want

http = Net::HTTP.new(host)          # Create a connection
headers, body = http.get(path)      # request the file
if headers.code == "200"            # Check the status code
  print body
else
  puts "#{headers.code} #{headers.message}"
end