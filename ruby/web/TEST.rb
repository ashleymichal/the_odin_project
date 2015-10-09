require './simple_server'
require './tiny_browser'

## short test suite for my simple_server/tiny_browser

# get_request = build_request('GET', $post_path, '')
# headers, body = get_request.split("\r\n\r\n", 2)
# puts parse_headers(headers)

# puts "\n-----\n"

post_content = build_post_content
request = build_request('POST', $post_path, post_content)
p request
headers, body = request.split("\r\n\r\n", 2)

p body
p JSON.parse(body).class
params = JSON.parse(body)

p process_post_request(body, $post_path)
# headers = request.split("\r\n\r\n", 2)[0]
# headers = parse_headers(headers)

# puts headers