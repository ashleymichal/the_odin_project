require 'rest-client'

url = 'http://localhost:3000/'
puts "the base url is #{url}"
puts "enter a path"
path = gets.chomp
puts "enter a request method: GET, POST, PUT, DELETE"
method = gets.chomp.downcase

valid_verbs = ['get', 'post', 'put', 'delete']
case method
when 'get'
	puts RestClient.get(url + path)
when 'post'
	puts RestClient.post(url + path, "")
end