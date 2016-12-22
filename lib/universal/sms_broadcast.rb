class SmsBroadcast
  
  def self.send(config, number, message, ref)
    clean_number = SmsBroadcast.clean_mobile_number(number)
    begin
      HTTParty.post( config.sms_url,
        body: {
          username: config.sms_username,
          password: config.sms_password,
          to: clean_number,
          from: config.sms_source,
          message: message,
          ref: ref
        }
      )
    rescue => error
      puts error
    end
  end
  
  def self.clean_mobile_number(number=nil)
    return nil if number.blank?
    code = '61'
    n = number.match(/^[\+]?(0|#{code})*([\d|\s]+)$/)
    return "#{code}#{n[2].gsub(' ','')}"
  end
  
end