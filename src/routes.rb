require_relative 'controllers/message'
require 'http_status'

HTTP_METHODS = {
  GET: 'GET',
  POST: 'POST',
}.freeze

ROUTES = {
  greet: '/api/greet',
  health_check: '/api/health-check',
  add_message: '/api/message',
  list_messages: '/api/messages',
}.freeze

def load_routes(server)
  # Greet
  server.mount_proc ROUTES[:greet] do |req, res|
    if req.request_method != HTTP_METHODS[:GET]
      res.status = HTTPStatus::MethodNotAllowed
      res.body = { error: 'Method not allowed' }.to_json
      next
    end

    MessageController.greet(req, res)
  end

  # Health-check
  server.mount_proc ROUTES[:health_check] do |req, res|
    if req.request_method != HTTP_METHODS[:GET]
      res.status = HTTPStatus::MethodNotAllowed
      res.body = { error: 'Method not allowed' }.to_json
      next
    end

    res.status = HTTPStatus::Ok
    res.body = { status: 'ok'}.to_json
  end

  # Add message
  server.mount_proc ROUTES[:add_message] do |req, res|
    if req.request_method != HTTP_METHODS[:POST]
      res.status = HTTPStatus::MethodNotAllowed
      res.body = { error: 'Method not allowed' }.to_json
      next
    end

    MessageController.add_message(req, res)
  end

  # List messages
  server.mount_proc ROUTES[:list_messages] do |req, res|
    if req.request_method != HTTP_METHODS[:GET]
      res.status = HTTPStatus::MethodNotAllowed
      res.body = { error: 'Method not allowed' }.to_json
      next
    end

    MessageController.list_messages(req, res)
  end
end
