require 'rufus/scheduler'
require 'gmail'
require 'mail'

scheduler = Rufus::Scheduler.start_new

scheduler.every("30s") do
  puts "Email Checking..."
  gmail = Gmail.new("site@siitcollab.co.cc", "site15951") do |g|
    unread_counts = g.inbox.count(:unread)

    puts unread_counts.to_s + " Unread Message(s)"

    g.inbox.emails(:unread).each do |mail|
      puts "----------------------"
      message = mail.message
      mailobj = Mail.new(mail.body)

      from = message.from
      to = message.to.split("@")[0]
      subject = message.subject

      puts "Marking as read..."
      mail.mark(:read)
      puts "done!"

#      Checks the group and user membership to that group
      group = Group.find_by_email(to)
      puts "#{to} group email not found!" if group.nil?
      user = User.find_by_email(from)
      puts "#{to}, no such user!" if user.nil?

      if not user.nil? and not group.nil? and group.has_member?(user)
        #Handle the attachments
        
        if mailobj.attachments.size > 0
          attachment = mailobj.attachments.first 

          Dir.mkdir("public/email_uploads") unless File.directory?("public/email_uploads")
          Dir.mkdir("public/email_uploads/#{group.email}") unless File.directory?("public/email_uploads/#{group.email}")

          new_filename = Time.now.to_i.to_s + "#{attachment.content_type_parameters[:name]}"
          filepath = "public/email_uploads/#{group.email}/#{new_filename}" 
          File.open(filepath, 'w') {|f| f.write(attachment.body)}
          
          #Create object according to mimetype
          share = Share::NewFromMime(`file -bi #{filepath}`.split(';')[0])
          case share.name
            when "Document"
                share.title = subject
                share.body = message.html || message.text
                share.file = "/email_uploads/#{group.email}/#{new_filename}"
            else
                share = News.new
                share.title = subject
                share.body = message.html || message.text
          end
        else #No file is attached, infer as News
          share = News.new
          share.title = subject
          share.body = message.html || message.text
        end
        
        share.share = Share.new(:user => user, :group => group)
        puts "Added a new share(#{share.title}) to #{group.name} by #{user.email}!" if share.save

        puts "Sending email out to users."

        group.members.each do |member|
          next if member.email == message.from
          puts "Sending email out to \"#{member.email}\"..."
          message.headers["reply-to"] = message.from
          message.headers["to"] = member.email
          message.subject("[#{group.name}] " + message.subject)
          content = message.content
          if(mailobj.attachments.size == 0)
            content[0].content = content[0].content + "\n\nSent via SIIT Collab <http://www.siitcollab.co.cc>"
            content[1].content = content[1].content + '<br/><br/><hr/>Sent Via <a href="http://www.siitcollab.co.cc" title="SIIT Collab Website">SIIT Collab</a>.'
          else
            content[0].content[0].content = content[0].content[0].content + "\n\n Sent via SIIT Collab <http://www.siitcollab.co.cc>"
            content[0].content[1].content = content[0].content[1].content + '<br/><br/><hr/>Sent Via <a href="http://www.siitcollab.co.cc" title="SIIT Collab Website">SIIT Collab</a>.'
          end
          message.content = content
          g.send_email(message)
        end

      else
        puts "Either user is not a member of this group, or user doesn't exist or group doesn't exist!"
      end

    end

    puts "\n\n\nEnough emailing for today!"
  end
 end
