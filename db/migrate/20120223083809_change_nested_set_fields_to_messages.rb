class ChangeNestedSetFieldsToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :nv, :integer
    add_column :messages, :dv, :integer
    add_column :messages, :snv, :integer
    add_column :messages, :sdv, :integer
    remove_column :messages, :rgt
    remove_column :messages, :lft
    root=Message.find 1
    root.nv,root.dv,root.snv,root.sdv=0,1,1,1
    root.save
    begin
      Message.joins(:message).where('messages_messages.dv>? and messages.dv=?',0,0).each do |m| # forse si riesce a fare meglio non usando le joins
        c=m.message.messages.where('dv>0').count+1
	m.nv,m.dv,m.snv,m.sdv=m.message.nv+c*m.message.snv,m.message.dv+c*m.message.sdv,m.message.nv+(c+1)*m.message.snv,m.message.dv+(c+1)*m.message.sdv
	m.save
      end
      tot=Message.joins(:message).where('messages_messages.dv>? and messages.dv=?',0,0).count
    end while tot>0
  end

  def down
    add_column :messages, :rgt, :integer
    add_column :messages, :lft, :integer
    remove_column :messages, :nv
    remove_column :messages, :dv
    remove_column :messages, :snv
    remove_column :messages, :sdv
    root=Message.find 1
    set_ns root,1
  end
  private
  def set_ns m,i
    m.lft=i
    i+=1
    m.messages.each do |n|
      i=set_ns n,i
    end
    m.rgt=i
    m.save
    i
  end
end
