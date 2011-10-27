module HashModule
  class SecureToken
    def self.generate_token
        SecureRandom.urlsafe_base64
    end
  end
end
