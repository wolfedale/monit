module Monit
  class Email
    def self.send_email(subject, body, recipient)
      tmp = body
      tmp = Tempfile.new("monit_email")
      tmp.write(body)
      tmp.rewind

      subject.gsub!("'", "\'")
      recipient.gsub!("'", "\'")

      system("cat #{tmp.path} | mail -s '#{subject}' '#{recipient}'")
    ensure
      tmp.close!
      tmp.unlink
    end
  end
end
    
