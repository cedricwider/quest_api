require 'digest/sha2'

module Encryptable

  def encrypt(clear_text)
    Digest::SHA2.hexdigest clear_text
  end

end
