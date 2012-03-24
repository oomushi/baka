module LikesHelper
  def link_to_submit text, params={}
    link_to_function text, "$(this).closest('form').submit()", params
  end
  def num_reduce n
    t,i=n.to_s,0
    while t.length > 3
      t=(t.to_i/1000).to_s
      i+=1
    end
    a=(['']<<%w(K M G T P)).flatten
    t+a[i]
  end
end
