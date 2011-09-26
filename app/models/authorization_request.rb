class AuthorizationRequest < ActiveRecord::Base
  belongs_to  :client_application
  
  attr_accessor :client_id, :client_secret
  attr_accessible :response_type, :redirect_uri, :scope, :state, :client_id, :client_secret

  before_save :eligible?

  def eligible?
    !code.nil?
  end

  def validate_request
    if response_type.nil? or client_id.nil? or client_secret.nil?
      return error_response "invalid_request"
    end

    unless response_type == "code"
      return error_response = "unsupported_response_type"
    end

    self.client_application = ClientApplication.find_by_app_id_and_app_secret(client_id,client_secret)
    if self.client_application.nil?
      return error_response "unauthorized_client"
    else
      self.code = client_application.generate_authorization_code
      if self.save
        return successful_response
      else
        return error_response "server error"
      end
    end
  end

  def error_response error_message
    hash = Hash.new
    hash[:error] = error_message
    hash[:state] = state unless state.nil?
    return hash
  end
  
  def successful_response
    hash = Hash.new
    hash[:code] = code
    hash[:state] = state unless state.nil?
    return hash
  end
end
