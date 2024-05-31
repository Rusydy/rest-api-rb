require_relative 'controllers/message'
require 'http_status'

def load_routes(server)
  # Greet
  server.mount_proc '/api/greet' do |req, res|
    MessageController.greet(req, res)
  end

  # Health-check
  server.mount_proc '/api/health-check' do |req, res|
    res.status = HTTPStatus::Ok
    res.body = { status: 'ok'}.to_json
  end
end
