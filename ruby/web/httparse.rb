class HTTPResponse
	## read in HTTP request and return information for response
	#######

	## process POST requests

	## build HTTP response according to standards

	# HTTP/1.0 200 OK
	# Date: Fri, 31 Dec 1999 23:59:59 GMT
	# Content-Type: text/html
	# Content-Length: 1354

	# <html>
	########
	def build_response(status, message, content)
		begin
			type = content.type
			length = content.length
		rescue
			status = '404'
			message = 'File Not Found'
		end
			response = "HTTP/1.0 #{status} #{message}\r\n
								 #{Time.new.asctime}\r\n
								 Content-Type:   #{type}\r\n
								 Content-Length: #{length}\r\n\r\n
								 #{content}"
	end

	## read in a response according to standards
	#########
	def read_response(response)
		headers,body = response.split("\r\n\r\n", 2)
		http,status,message = headers.split(" ", 3)
		case status
		when '404'
			return "#{status} - #{message}"
		else
			return body
		end
	end
end