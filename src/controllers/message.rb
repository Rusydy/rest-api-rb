require 'json'
require_relative '../services/message'

class MessageController
  def self.greet(req, res, db_connection)
    message = MessageService.get_greeting(db_connection)
    res.content_type = 'application/json'
    res.body = { message: message }.to_json
  end
end
