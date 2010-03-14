require 'rubygems'
require 'gmail'
require 'mail'

gmail = Gmail.new("site@siitcollab.co.cc", "site15951") do |g|
#gmail = Gmail.new("mp.bodhisuwan@gmail.com", "25032503") do |g|
  unread_counts = g.inbox.count(:unread)

  puts unread_counts.to_s + " Unread Message(s)"

  g.inbox.emails(:unread).each do |mail|
    puts "----------------------"
    message = mail.message
    mailobj = Mail.new(mail.body)
    puts "From: #{message.from}"
    puts "To: #{message.to}"
    puts "Subject: #{message.subject}"
    puts "Date: #{mailobj.date}"
    puts "Message Body: \n#{message.to_yaml}\n\n"
    puts "Attachment(s): #{mailobj.attachments.size}"
    mailobj.attachments.each do |attachment|
      puts "\t#{attachment.content_type_parameters[:name]}"

      folder_name = "mpbod"
      Dir.mkdir("/home/mpbod/tmp/#{folder_name}") unless File.directory?("/home/mpbod/tmp/#{folder_name}")

      timestamp = Time.now.to_i.to_s
      new_filename = "#{attachment.content_type_parameters[:name]}"
      File.open("/home/mpbod/tmp/#{folder_name}/#{new_filename}", 'w') {|f| f.write(attachment.body)}
    end

    print "Marking as read..."
    mail.mark(:read)
    puts "done!"

    puts "Sending email out to \"mp.bodhisuwan@gmail.com\"..."
    email = "mp.bodhisuwan@gmail.com"
    message.headers["reply-to"] = message.from
    message.headers["to"] = email
    message.subject(message.subject + " #siitcollab")
    content = message.content
    if(mailobj.attachments.size == 0)
      content[0].content = content[0].content + "\n\nSent via SIIT Collab <http://www.siitcollab.co.cc>"
      content[1].content = content[1].content + '<br/><br/><hr/>Sent Via <a href="http://www.siitcollab.co.cc" title="SIIT Collab Website">SIIT Collab</a>.'
    else
      content[0].content[0].content = content[0].content[0].content + "\n\n Sent via SIIT Collab <http://www.siitcollab.co.cc>"
      content[0].content[1].content = content[0].content[1].content + '<br/><br/><hr/>Sent Via <a href="http://www.siitcollab.co.cc" title="SIIT Collab Website">SIIT Collab</a>.'
    end
    message.content = content
    #g.send_email(message)
  end
  puts "\n\n\nEnough emailing for today!"
end
