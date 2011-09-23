class AuthorizationRequest < ActiveRecord::Base
  belongs_to  :client_application
  attr_accessor :response_type, :client_id, :client_secret, :redirect_uri, :scope, :state
  validates_presence_of :response_type, :client_id, :client_secret

  after_initialize :after_initialize

  def generate_response
    client_application = ClientApplication.find_by_app_id_and_app_secret(client_id,client_secret)
    if client_application.nil?
      return error_response "unauthorized_client" 
    else
      code = client_application.generate_authorization_code
      save
      response = Hash.new
      response[:code] = code
      response[:state] = state unless state.nil?
      return response
    end
  end

  def error_response error_message
    hash = Hash.new
    hash[:error] = error_message
    hash[:state] = state unless state.nil?
    return hash
  end
  
  private

  def after_initialize
    unless self.valid?
      raise "invalid_request"
    end
    unless response_type == "code"
      raise "unsupported_response_type"
    end
  end
end
