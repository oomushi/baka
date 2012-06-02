class MessageMailer < ActionMailer::Base
  default :from => "admin@baka.macrobug.uchi.invalid", 
          :content_type =>  "text/html"
  def new_message_alert message
    @message=message
    users=[]
    user=message.user
    # TODO ancestors DEVE avere un parametro
    message.ancestors(message.user).where('follow = ? and messages.id <> ?',true,message.id).each do |m|
      users<<m.user.email unless user.eql? m.user
    end
    users.uniq.each do |email|
      mail :to=>email, :subject=>'New replay'
    end
  end
end
