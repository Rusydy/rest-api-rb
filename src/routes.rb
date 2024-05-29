require_relative 'controllers/message'

def load_routes(server, db_connection)
  # Define a basic GET route
  server.mount_proc '/api/greet' do |req, res|
    MessageController.greet(req, res, db_connection)
  end
end
