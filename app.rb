require 'webrick'
require 'json'
require 'pg'
require 'dotenv/load'

# Database configuration
DB_CONFIG = {
  dbname: ENV['DB_NAME'],
  user: ENV['DB_USER'],
  password: ENV['DB_PASSWORD'],
  host: ENV['DB_HOST'],
  port: ENV['DB_PORT'] || 5432 # Use default port 5432 if not set
}

# Connect to the database
begin 
  conn = PG.connect(DB_CONFIG)
  puts 'Connected to the database'
rescue PG::Error => e
  puts "Unable to connect to the database: #{e.message}"
  exit
end

# Ping the database
begin
  res = conn.exec('SELECT 1')
  puts 'Ping the database: ' + res[0]['?column?']
rescue PG::Error => e
  puts "Unable to ping the database: #{e.message}"
  exit
end

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