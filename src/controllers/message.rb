require 'json'
require_relative '../services/message'
require 'http_status'

class MessageController
  def self.greet(req, res)
    message = MessageService.get_greeting()

    res.status = HTTPStatus::Ok
    res.content_type = 'application/json'
    res.body = { message: message }.to_json
  end

  def self.add_message(req, res)
    if req.body.nil?
      res.status = HTTPStatus::BadRequest
      res.body = { error: 'Body is required' }.to_json
      return
    end

    body = JSON.parse(req.body)
    puts "The body is #{body}"

    message = body['message']

    if message.nil?
      res.status = HTTPStatus::BadRequest
      res.body = { error: 'Message is required' }.to_json
    end

    # TODO: Implement this method later
    # MessageService.add_message(message)
    puts "The message is #{message}"

    res.status = HTTPStatus::Created
    res.body = { message: 'Message added' }.to_json
  end
end
