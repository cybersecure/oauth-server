class OauthController < ApplicationController
  def authorize
    response = Hash.new
    begin
      request = AuthorizationRequest.new(params.except(:action,:controller,:other_key))
    rescue => exception
      response[:error] = exception.to_s
      response[:state] = params[:state] unless params[:state].nil?
      render :json => response.to_json
      return
    end
    response = request.generate_response
    render :json => response.to_json
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
