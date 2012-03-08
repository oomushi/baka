class MessageMailer < ActionMailer::Base
  default :from => "admin@baka.macrobug.uchi.invalid", 
          :content_type =>  "text/html"
  def new_message_alert message
    @message=message
    users=[]
    message.ancestors.where('follow = ?',true).each do |m|
      users<<m.user.email
    end
    users.uniq.each do |email|
      mail :to=>email, :subject=>'New replay'
    end
  end
end
