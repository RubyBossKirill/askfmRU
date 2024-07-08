require 'openssl'

class User < ApplicationRecord
    ITERATIONS = 20_000
    DIGEST = OpenSSL::Digest::SHA256.new
    REGEX_FORMAT_EMAIL = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
    REGEX_FORMAT_USERNAME = /\A[a-zA-Z0-9_]+\z/

    has_many :questions, dependent: :destroy

    attr_accessor :password, :password_confirmation

    validates :email, :username, presence: true
    validates :email, :username, uniqueness: { case_sensitive: false }
    validates :email, format: { with: REGEX_FORMAT_EMAIL, message: "must be a valid email address" }
    validates :username, length: { in: 6..30 }, format: { with: REGEX_FORMAT_USERNAME , message: "must be a valid username" }
    validates :password, presence: true, confirmation: true, on: :create
    validates :password_confirmation, presence: true

    before_save :encrypt_password, :downcase_email_and_username

    def self.authenticate(email, password)
        user = find_by(email: email)

        return nil unless user.present?

        hashed_password = User.hash_to_string(
            OpenSSL::PKCS5.pbkdf2_hmac(
                password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
            )
        )

        return user if user.password_hash == hashed_password

        nil
    end
    
    def self.hash_to_string(password_hash)
        password_hash.unpack('H*')[0]
    end

    private

    def encrypt_password
        if password.present?
            self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
            
            self.password_hash = User.hash_to_string(
                OpenSSL::PKCS5.pbkdf2_hmac(
                    password, password_salt, ITERATIONS, DIGEST.length, DIGEST
                )
            )
        end
    end

    def downcase_email_and_username
        self.email = email.downcase
        self.username = username.downcase
    end

end
