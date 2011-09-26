class OauthController < ApplicationController
  def authorize
    auth_request = AuthorizationRequest.new(params.except(:action,:controller,:other_key))
    response_hash = auth_request.validate_request
    auth_request.save
    render :json => response_hash.to_json
  end

  def access_token
    unless params[:grant_type].nil? or params[:code].nil?
      auth_request = AuthorisationRequest.find_by_code(params[:code])
      auth_redirect_uri = auth_request.redirect_uri
      if auth_redirect_uri.nil? or params[:redirect_uri] == auth_redirect_uri
      else
      end
    else
    end
  end
end
