require 'webrick'
require 'json'

server = WEBrick::HTTPServer.new(:Port => 8000)

# Define a basic GET route
server.mount_proc '/api/greet' do |req, res|
  res.content_type = 'application/json'
  res.body = { message: 'Hello, World!' }.to_json
end

# Start the server
trap 'INT' do 
  server.shutdown 
end

server.start