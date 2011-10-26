class OauthController < ApplicationController
  
  def auth_token
    auth_request = AuthorizationRequest.new(params.except(:action,:controller,:other_key))
    if auth_request.valid_request?
      if current_user.nil?
        redirect_to login_path(auth_request.id)
      else
        redirect_to authorise_app_path(auth_request.id) 
      end
    else
      render :json => auth_request.response
    end
  end

  def show_authorisation_dialog
    auth_id = params[:auth_request_id]
    unless auth_id.nil?
      if current_user
        @auth_request = AuthorizationRequest.find(auth_id)
        if @auth_request
          render :authorise_app
        else
          raise 'invalid authorization request'
        end
      else
        redirect_to login_path(auth_id)
      end
    else
      raise 'No authorization request specified'
    end
  end

  def authorise_app
    auth_id = params[:auth_request_id]
    unless auth_id.nil?
      if current_user
        @auth_request = AuthorizationRequest.find(auth_id)
        if @auth_request
          @auth_request.generate_code
          render :json => @auth_request.response
        else
          raise 'invalid authorization request'
        end
      else
        redirect_to login_path(auth_id)
      end
    else
      raise 'No authorization request specified'
    end
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
