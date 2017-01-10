module FakeSms

  Message = Struct.new(:num, :msg)
  @messages = []

  def self.send_sms(number:, message: )
    @messages << Message.new(number, message)
  end

  def self.messages
    @messages
  end

end
