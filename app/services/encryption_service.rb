# Handy class which encrypts and decrypts values
# see https://pawelurbanek.com/rails-secure-encrypt-decrypt
class EncryptionService
  delegate :encrypt_and_sign, :decrypt_and_verify, to: :encryptor

  def self.encrypt(value)
    new.encrypt_and_sign(value)
  end

  def self.decrypt(value)
    new.decrypt_and_verify(value) if value.present?
  end

  private

  def encryptor
    ActiveSupport::MessageEncryptor.new(encryptor_key)
  end

  def encryptor_key
    ActiveSupport::KeyGenerator.new(
      secret_key_base
    ).generate_key(
      encryption_service_salt,
      ActiveSupport::MessageEncryptor.key_len
    ).freeze
  end

  def secret_key_base
    Rails.application.credentials.config[:secret_key_base]
  end

  def encryption_service_salt
    Rails.application.credentials.config[:encryption_service_salt]
  end
end
