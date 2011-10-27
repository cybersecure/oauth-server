class AccessRequest < Hashable
  belongs_to  :authorization_request
  
  attr_accessor :code
  attr_accessible :grant_type, :redirect_uri, :scope, :state, :code

  def validate_request
    if grant_type.nil? or code.nil?
      return error_response "invalid_request"    
    end

    unless grant_type == "authorization_code"
      return error_response "unsupported_grant_type"
    end

    auth_request = AuthorizationRequest.find_by_code(code)

    if auth_request.nil? or auth_request.invalid?
      return error_response "invalid_client"    
    else
      unless auth_request.redirect_uri == redirect_uri and auth_request.state == state
        return error_response "invalid_grant"    
      end
      unless auth_request.scope == scope
        return error_response "invalid_scope"    
      end

      # Now Starts the successful request
      
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
    hash[:access_token] = generate_access_token
    hash[:refresh_token] = generate_refresh_token
    hash[:state] = state unless state.nil?
    return hash
  end

  def generate_access_token
    self.access_token = "abc123"
    self.expire_in = 3600
  end
  
  def generate_refresh_token
    self.refresh_token = "abc123"
  end

end
