class GoogleAuthorizationsController < ApplicationController
  authorize_resource

  def new    
  end

  def claim
    redirect_to auth.authorization_uri.to_s, status: 303
  end

  def grant
    auth.code = params[:code] if params[:code]

    begin
      auth.fetch_access_token!
    rescue ArgumentError => error
      return redirect_to root_path
    end

    puts '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
    puts auth.inspect

    ga = GoogleAuthorization.find_or_initialize_by(user: current_user)
    ga.access_token = auth.access_token
    ga.refresh_token = auth.refresh_token
    ga.issued_at = auth.issued_at
    ga.expires_at = ga.issued_at + auth.expires_in
    ga.save!

    redirect_to new_project_path
  end

  protected

  def auth
    @auth ||= (
      auth = api_client.authorization.dup
      auth.redirect_uri = grant_google_authorizations_url
      auth
    )
  end

  def api_client
    @client ||= (
      client = Google::APIClient.new
      client.authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
      client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
      client.authorization.scope = 'https://www.googleapis.com/auth/drive'
      client
    )
  end
end
