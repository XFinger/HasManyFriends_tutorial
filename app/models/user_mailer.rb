class UserMailer < ActionMailer::Base
    
  def invite(user, recipient) 
    @user=user
    @subject = "Invitation"
    @from = "my website"
    @body[:url] = "http://192.168.1.3:3004"  #set to your ip address or domain name
    @recipients = recipient
    @sent_on = Time.now
    content_type 'text/html' 
  end
 
end
