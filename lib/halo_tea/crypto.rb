module HaloTea
  class Crypto
    extend FFI::Library
    ffi_lib FFI::Compiler::Loader.find("halo_pck_algo")

    attach_function "halo_generate_keys", [:pointer, :pointer, :pointer], :void
    attach_function "halo_tea_decrypt", [:pointer, :int, :pointer], :void
    attach_function "halo_tea_encrypt", [:pointer, :int, :pointer], :void
    attach_function "halo_crc32", [:pointer, :int], :uint32

    def self.crc32(data)
      halo_crc32(data, data.size)
    end

    def self.generate_keys( hash = nil, source_key = nil)
      dest_key = FFI::MemoryPointer.new(:uint8, 16)
      hash_ptr = process_hash(hash)
      halo_generate_keys(hash_ptr, process_source_key(source_key), dest_key)
      [hash_ptr.read_bytes(16), dest_key.read_bytes(16)]
    end

    def self.decrypt( buffer, key )
      buffer_ptr = FFI::MemoryPointer.new(:uint8, buffer.length)
      buffer_ptr.write_bytes(buffer)
      halo_tea_decrypt( buffer_ptr, buffer_ptr.size, key)
      buffer_ptr.read_bytes(buffer_ptr.size)
    end

    def self.encrypt( buffer, key )
      buffer_ptr = FFI::MemoryPointer.new(:uint8, buffer.length)
      buffer_ptr.write_bytes(buffer)
      halo_tea_encrypt( buffer_ptr, buffer_ptr.size, key)
      buffer_ptr.read_bytes(buffer_ptr.size)
    end

    # private methods
    def self.process_hash( h )
      hash_ptr = FFI::MemoryPointer.new(:uint8, 17)
      hash_ptr.write_bytes(h) unless h.nil?
      hash_ptr
    end

    def self.process_source_key( key )
      return key if key.nil?
      key_ptr = FFI::MemoryPointer.new(:uint8, 16)
      key_ptr.write_bytes(key)
      key_ptr
    end
  end
end
