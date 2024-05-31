require 'json'
require_relative '../services/message'
require 'http_status'

class MessageController
  def self.greet(req, res, db_connection)
    message = MessageService.get_greeting(db_connection)

    res.status = HTTPStatus::Ok
    res.content_type = 'application/json'
    res.body = { message: message }.to_json
  end
end
