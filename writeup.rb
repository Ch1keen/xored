=begin
I was given the following equations. Can you help me decode the flag?

Key 1 = 5dcec311ab1a88ff66b69ef46d4aba1aee814fe00a4342055c146533
Key 1 ^ Key 3 = 9a13ea39f27a12000e083a860f1bd26e4a126e68965cc48bee3fa11b
Key 2 ^ Key 3 ^ Key 5 = 557ce6335808f3b812ce31c7230ddea9fb32bbaeaf8f0d4a540b4f05
Key 1 ^ Key 4 ^ Key 5 = 7b33428eb14e4b54f2f4a3acaeab1c2733e4ab6bebc68436177128eb
Key 3 ^ Key 4 = 996e59a867c171397fc8342b5f9a61d90bda51403ff6326303cb865a
Flag ^ Key 1 ^ Key 2 ^ Key 3 ^ Key 4 ^ Key 5 = 306d34c5b6dda0f53c7a0f5a2ce4596cfea5ecb676169dd7d5931139
=end

def hexstr_to_intarr(hexstr)
  intarr = Array.new

  hexstr.scan(/../) do |bytes|
    intarr.push(bytes.to_i(16))
  end

  return intarr
end

def xor_intarr(intarr1, intarr2)
  xored = Array.new

  intarr1.length.times do |i|
    xored.push(intarr1[i]^intarr2[i])
  end

  return xored
end


key1 = "5dcec311ab1a88ff66b69ef46d4aba1aee814fe00a4342055c146533"
key13 = "9a13ea39f27a12000e083a860f1bd26e4a126e68965cc48bee3fa11b"
key235 = "557ce6335808f3b812ce31c7230ddea9fb32bbaeaf8f0d4a540b4f05"
key145 = "7b33428eb14e4b54f2f4a3acaeab1c2733e4ab6bebc68436177128eb"
key34 = "996e59a867c171397fc8342b5f9a61d90bda51403ff6326303cb865a"
flag12345 = "306d34c5b6dda0f53c7a0f5a2ce4596cfea5ecb676169dd7d5931139"


# key3 = key1 ^ key1^key3
key3 = xor_intarr(hexstr_to_intarr(key1),hexstr_to_intarr(key13))

# key4 = key3^key4 ^ key3
key4 = xor_intarr(hexstr_to_intarr(key34),key3)

key45 = xor_intarr(hexstr_to_intarr(key145),hexstr_to_intarr(key1))
key5 = xor_intarr(key45,key4)

key23 = xor_intarr(hexstr_to_intarr(key235),key5)
key2 = xor_intarr(key23,key3)

flag23 = xor_intarr(hexstr_to_intarr(flag12345),hexstr_to_intarr(key145))
flag2 = xor_intarr(flag23,key3)
flag = xor_intarr(flag2,key2)

flag.each {|bytes| print bytes.chr}
puts
#=> flag{n0t_t00_h4rD_h0p3fully}
