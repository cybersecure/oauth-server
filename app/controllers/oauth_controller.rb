class OauthController < ApplicationController
  
  def auth_token
    auth_request = AuthorizationRequest.new(params.except(:action,:controller,:other_key))
    if auth_request.valid_request?
      session[:auth_request] = auth_request.session_store
      if current_user.nil?
        redirect_to login_path
      else
        redirect_to authorise_app_path
      end
    else
      send_results(auth_request)
    end
  end

  def show_authorisation_dialog
    handle_auth_request do
      client_application_id ||= @auth_request_data[:client_application_id]
      @client_application ||= ClientApplication.find(client_application_id) unless client_application_id.nil?
      unless @client_application.nil?
        auth_request = AuthorizationRequest.find_by_user_id_and_client_application_id(current_user.id,client_application_id)
        if auth_request.nil? or auth_request.expired?
          render 'auth_dialog'
        else
          send_results(auth_request)
        end
      else
        raise 'invalid authorization request'
      end
    end
  end

  def authorise_app
    handle_auth_request do
      auth_request = AuthorizationRequest.new(@auth_request_data)
      auth_request.setup(@auth_request_data[:client_application_id],current_user.id)
      send_results(auth_request)  
    end
  end

  def handle_auth_request
    if current_user
      @auth_request_data = session[:auth_request]
      unless @auth_request_data.nil?
        yield
      else
        raise 'No authorization request specified'
      end
    else
      redirect_to login_path
    end
  end

  def send_results(auth_request)
    session[:auth_request] = nil
    redirect_to auth_request.redirect_request_uri
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
