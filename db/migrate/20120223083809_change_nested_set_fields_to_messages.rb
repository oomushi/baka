class ChangeNestedSetFieldsToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :nv, :integer,:default=>0,:limit=>8
    add_column :messages, :dv, :integer,:default=>0,:limit=>8
    add_column :messages, :snv, :integer,:default=>0,:limit=>8
    add_column :messages, :sdv, :integer,:default=>0,:limit=>8
    remove_column :messages, :rgt
    remove_column :messages, :lft
    begin
      root=Message.find 1
      root.nv,root.dv,root.snv,root.sdv=0,1,1,1
      root.save
      begin
        Message.joins(:message).where('messages_messages.dv>0 and messages.dv=0').readonly(false).each do |m| # forse si riesce a fare meglio non usando le joins
          c=m.message.messages.where('dv>0').count+1
          c-=1 if m.message.id==1
          m.nv,m.dv,m.snv,m.sdv=m.message.nv+c*m.message.snv,m.message.dv+c*m.message.sdv,m.message.nv+(c+1)*m.message.snv,m.message.dv+(c+1)*m.message.sdv
          m.save
        end
        tot=Message.joins(:message).where('messages_messages.dv>? and messages.dv=?',0,0).count
      end while tot>0
    rescue
    end
  end

  def down
    add_column :messages, :rgt, :integer,:default=>0
    add_column :messages, :lft, :integer,:default=>0
    remove_column :messages, :nv
    remove_column :messages, :dv
    remove_column :messages, :snv
    remove_column :messages, :sdv
    begin
      n=Message.find(1)
      stack=[n]
      right=[]
      i=1
      while stack.length > 0
        n=stack.shift
        unless n.nil?
          n.lft=i
          i+=1
          c= n.id==n.message_id ? 1 : 0
          if n.messages.count>c 
            stack.unshift nil
            right.unshift n
            stack.unshift(*n.messages)
            stack.delete n
          else
            n.rgt=i
            i+=1
          end
          n.save
        else
          m=right.shift
          m.rgt=i
          i+=1
          m.save
        end
      end
    rescue
    end
  end
end