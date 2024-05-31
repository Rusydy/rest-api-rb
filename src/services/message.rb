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
  $conn = PG.connect(DB_CONFIG)
  puts 'Connected to the database'
rescue PG::Error => e
  puts "Unable to connect to the database: #{e.message}"
  exit
end

=begin
  The code above connects to the database. The connection is stored in the global variable $conn.
  Of course, this is not the best way to handle database connections in a real-world application.
  In a production application, it should use a connection pool to manage database connections.
=end

class MessageService
  def self.get_greeting()
    result = $conn.exec("SELECT message FROM greetings WHERE id = 1;")
    result[0]['message'] # Assuming there's at least one row with id = 1
  end

  def self.add_message(message)
    begin
      query = $conn.exec_params("INSERT INTO messages (message) VALUES ($1) RETURNING id;", [message])
      puts "this is the result from query #{query[0]}"
      id = query[0]['id']
    rescue PG::Error => e
      puts "this is the error from query #{e.message}"
      return { error: e.message }
    end

    { id: id }
  end
end
