class AuthorizationRequest < ActiveRecord::Base
  include HashModule
  
  belongs_to  :client_application
  belongs_to  :user
 
  attr_accessor :response, :client_id, :client_secret
  attr_accessible :response_type, :redirect_uri, :scope, :state, :client_id, :client_secret

  def valid_request?
    if response_type.nil? or client_id.nil? or client_secret.nil? or redirect_uri.nil?
      self.response "invalid_request"
      return false
    end

    unless response_type == "code"
      self.response "unsupported_response_type"
      return false
    end

    self.client_application = ClientApplication.find_by_client_id_and_client_secret(client_id,client_secret)
    if self.client_application.nil?
      self.response "unauthorized_client"
      return false
    else
      if self.save
        return true
      else
        self.response "server error"
        return false
      end
    end
  end

  def redirect_request_uri
    if self.code.nil?
      query_string = "error=#{self.response}"
    else
      query_string = "code=#{self.code}"
    end
    query_string += "&state=#{self.state}" unless self.state.nil?
    uri = URI::HTTP.build(:host => redirect_uri, :query => query_string)
    if uri..to_s
  end

  def approve
    self.code = HashModule::SecureToken.generate_token
    unless self.save
      self.response "server error"
    end
  end
end
