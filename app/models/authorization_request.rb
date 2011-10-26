class AuthorizationRequest < ActiveRecord::Base
  belongs_to  :client_application
  belongs_to  :user
 
  attr_accessor :response, :client_id, :client_secret
  attr_accessible :response_type, :redirect_uri, :scope, :state, :client_id, :client_secret

  def set_response( message = nil )
    self.response = Hash.new
    if message.nil?
      self.response[:code] = self.code
    else
      self.response[:error] = message
    end
    self.response[:state] = state unless state.nil?
  end
  
  def valid_request?
    if response_type.nil? or client_id.nil? or client_secret.nil? or redirect_uri.nil?
      self.set_response "invalid_request"
      return false
    end

    unless response_type == "code"
      self.set_response "unsupported_response_type"
      return false
    end

    self.client_application = ClientApplication.find_by_app_id_and_app_secret(client_id,client_secret)
    if self.client_application.nil?
      self.set_response "unauthorized_client"
      return false
    else
      if self.save
        return true
      else
        self.set_response "server error"
        return false
      end
    end
  end

  def generate_code
      self.code = client_application.generate_authorization_code
      if self.save
        self.set_response
      else
        self.set_response "server error"
      end
  end
end
