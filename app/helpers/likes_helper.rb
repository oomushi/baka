module LikesHelper
  def num_reduce n
    t,i=n.to_s,0
    while t.length > 3
      t=(t.to_i/1000).to_s
      i+=1
    end
    a=(['']<<%w(K M G T P E Z Y)).flatten
    t+a[i]
  end
end
