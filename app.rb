require 'webrick'
require 'pg'
require 'dotenv/load'
require_relative 'src/routes'

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

# Load routes
load_routes(server, conn)

# Start the server
trap 'INT' do 
  server.shutdown
  conn.close if conn
  puts 'Server and database connection closed gracefully'
end

server.start