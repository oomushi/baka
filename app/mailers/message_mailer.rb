class MessageMailer < ActionMailer::Base
  default :from => "baka@macrobug.dev.invalid"
  def new_message_alert message
    @message=message
    users=[]
    user=message.user
    message.ancestors(message.user).where('follow = ? and messages.id <> ?',true,message.id).each do |m|
      users<<m.user.email unless user.eql? m.user
    end
    users.uniq.each do |email|
      mail :to=>email, :subject=> t(:new_replay)
    end
  end
end
