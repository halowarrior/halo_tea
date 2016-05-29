require 'halo_tea'
require 'zlib'
# [0].pack("L>").unpack("H*")
path = "/Users/adam/Desktop/bloodgulch.map"
contents = open(path, "rb") {|io| io.read }

puts Zlib.crc32(contents)
puts HaloTea::Crypto.crc32(contents)
