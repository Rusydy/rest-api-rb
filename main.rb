require 'webrick'
require_relative 'src/routes'

server = WEBrick::HTTPServer.new(:Port => 8000)

# Load routes
load_routes(server)

# Start the server
trap 'INT' do
  server.shutdown
  conn.close if conn
  puts 'Server and database connection closed gracefully'
end

server.start
