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
    return unless validate_add_message_request(req, res)

    body = JSON.parse(req.body)
    message = body['message']

    result = MessageService.add_message(message)
    if result[:error]
      res.status = HTTPStatus::InternalServerError
      res.body = { error: result[:error] }.to_json
      return
    end

    res.status = HTTPStatus::Created
    res.body = {
      message: 'Message added',
      id: result[:id]
    }.to_json
  end

  # list_messages
  def self.list_messages(req, res)
    messages = MessageService.list_messages()

    res.status = HTTPStatus::Ok
    res.content_type = 'application/json'
    res.body = { messages: messages }.to_json
  end

  private

  def self.validate_add_message_request(req, res)
    if req.body.nil?
      res.status = HTTPStatus::BadRequest
      res.body = { error: 'Body is required' }.to_json
      return false
    end

    body = JSON.parse(req.body)
    message = body['message']
    if message.nil?
      res.status = HTTPStatus::BadRequest
      res.body = { error: 'Message is required' }.to_json
      return false
    end

    true
  end
end
