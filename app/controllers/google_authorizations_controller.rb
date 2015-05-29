class GoogleAuthorizationsController < ApplicationController
  authorize_resource

  def new
  end

  def claim
    auth = GoogleDrive.generate_authorization
    auth.redirect_uri = grant_google_authorizations_url
    redirect_to auth.authorization_uri.to_s, status: 303
  end

  def grant
    auth = GoogleDrive.generate_authorization
    auth.code = params[:code] if params[:code]
    auth.redirect_uri = grant_google_authorizations_url
    auth.grant_type = "authorization_code"

    begin
      auth.fetch_access_token!
    rescue ArgumentError => error
      return redirect_to root_path
    end

    puts '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
    puts auth.inspect

    ga = GoogleAuthorization.find_or_initialize_by(user: current_user)
    ga.access_token = auth.access_token
    ga.refresh_token = auth.refresh_token if auth.refresh_token.present?
    ga.issued_at = auth.issued_at
    ga.expires_at = ga.issued_at + auth.expires_in
    ga.save!

    redirect_to new_project_path
  end
end
