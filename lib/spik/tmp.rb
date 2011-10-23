
# def can(*args)
#   p args.first
# end
# 
# def you(*args)
#   args.first
# end
# 
# def say(*args)
#   args.first
# end

def method_missing(m, *a)
  m.to_s
end

# can you say please?

def make(*args)
  p args.first
end

def me(*args)
  case args.first
  when 'happy!'
    'smile, bitch ^_^'
  else
    "r u sad bastard? c'mon!!!"
  end
end

def girl(*args)
  case args.first
  when /happy/
    ':P'
  else
    'SLAP!'
  end
end

make me happy!

make girl happy

chain = Proc.new do |*methods|
  p methods.to_s + '123'
end

p chain.call(make.to_proc)