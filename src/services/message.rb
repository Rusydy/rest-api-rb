class MessageService
  def self.get_greeting(db_connection)
    result = db_connection.exec("SELECT message FROM greetings WHERE id = 1;")
    result[0]['message'] # Assuming there's at least one row with id = 1
  end
end
