require 'openssl'

class Encryption
  def self.decrypt(password:, encrypted_content:)
  end

  def self.encrypt(password:, content:)
    key = OpenSSL::Digest::SHA256.new.digest password
    cipher=OpenSSL::Cipher.new("AES-128-CBC")
    cipher.encrypt
    cipher.key = key

    cipher.update(content) + cipher.final
  end
end
