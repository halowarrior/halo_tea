require 'spec_helper'
require 'zlib'

describe HaloTea::Crypto do
  describe "generate_keys" do
    it "returns the right length for hash" do
      hash, key = HaloTea::Crypto.generate_keys
      expect(hash.length).to eql(16)
    end
    it "returns the right length for key" do
      hash, key = HaloTea::Crypto.generate_keys
      expect(key.length).to eql(16)
    end

    it "encrypts and decrypts" do
      10000.times do
        data = "ABCD0000"
        hash, key = HaloTea::Crypto.generate_keys
        encrypted = HaloTea::Crypto.encrypt(data,key)
        expect(HaloTea::Crypto.decrypt(encrypted,key)).to eql(data)
      end
    end

    it "decrypts 38 byte string (join packet)" do
      10000.times do
        data = 38.times.map{"a"}.join
        hash, key = HaloTea::Crypto.generate_keys
        encrypted = HaloTea::Crypto.encrypt(data,key)
        expect(HaloTea::Crypto.decrypt(encrypted,key)).to eql(data)
      end
    end

    it "generates a second key" do
      # pending "need to write spec"
      # hash, second_key = HaloTea::Crypto.generate_keys(hash, key)
    end
  end

  describe "crc32" do
    it "returns the correct value" do
      halo_crc32 = HaloTea::Crypto.crc32("ABC")
      expect(halo_crc32).to eql(Zlib.crc32("ABC"))
    end
    it "returns the correct value again" do
      value = "SDFSDFSdf23234asdfasdf342134asfjnznzzaA"
      halo_crc32 = HaloTea::Crypto.crc32(value)
      expect(halo_crc32).to eql(Zlib.crc32(value))
    end
  end
end
