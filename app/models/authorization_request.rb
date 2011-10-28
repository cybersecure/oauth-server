require 'addressable/uri'

class AuthorizationRequest < ActiveRecord::Base
  include HashModule
  
  belongs_to  :client_application
  belongs_to  :user
 
  attr_accessor :client_id, :client_secret, :response
  attr_accessible :response_type, :redirect_uri, :scope, :state, :client_id, :client_secret

  def valid_request?
    if response_type.nil? or client_id.nil? or client_secret.nil? or redirect_uri.nil?
      self.response = "invalid_request"
      return false
    end

    unless response_type == "code"
      self.response = "unsupported_response_type"
      return false
    end

    self.client_application = ClientApplication.find_by_client_id_and_client_secret(client_id,client_secret)
    if client_application.nil?
      self.response = "unauthorized_client"
      return false
    end
    return true
  end

  def session_store
    session_store = Hash.new
    session_store[:response_type] = self.response_type
    session_store[:redirect_uri] = self.redirect_uri
    session_store[:state] = self.state
    session_store[:scope] = self.scope
    session_store[:client_application_id] = self.client_application.id
    session_store
  end

  def redirect_request_uri
    query_hash = Hash.new
    if self.code.nil?
      query_hash[:error] = self.response
    else
      query_hash[:code] = self.code
    end
    query_hash[:state] = self.state unless self.state.nil?
    host_uri = Addressable::URI.parse(redirect_uri)
    uri = "#{host_uri.to_s}?#{Addressable::URI.form_encode(query_hash)}"
  end

  def setup(new_client_application_id,new_user_id)
    if new_client_application_id.nil? or new_user_id.nil?
      self.response = "server error"
    else
      self.client_application_id = new_client_application_id 
      self.user_id = new_user_id 
      self.code = HashModule::SecureToken.generate_token
      unless self.save
        self.response = "server error"
      end
    end
  end

  def expired?
    false
  end
end
