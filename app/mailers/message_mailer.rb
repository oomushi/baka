class MessageMailer < ActionMailer::Base
  def new_message_alert message
    users=[]
    message.ancestors.where('follow = ?',true).each do |m|
      users<<m.user.email
    end
    users.uniq.each do |email|
      mail :to=>email, :subject=>'New replay'
    end
  end
end
