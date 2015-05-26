# TODO: mover esse require para a inicialização do Rails
require 'google/api_client'

class GoogleAuthorizationsController < ApplicationController
  # TODO: remover esse skip e permitir apenas admins acessarem essa controller
  skip_authorization_check

  # TODO: escrever uns testes para essa action
  def authorize
    redirect_to auth.authorization_uri.to_s, status: 303
  end

  # TODO: escrever uns testes para essa action
  def callback
    auth.code = params[:code] if params[:code]
    auth.fetch_access_token!

    # TODO: além de criar novas autorizações o código deve prever a atualização de
    # autorização já existentes
    GoogleAuthorization.create(
      user: current_user,
      access_token: auth.access_token,
      refresh_token: auth.refresh_token,
      issued_at: auth.issued_at,
      expires_at: auth.issued_at + auth.expires_in
    )

    redirect_to new_project_path
  end

  protected

  def auth
    @auth ||= (
      auth = api_client.authorization.dup
      auth.redirect_uri = google_authorizations_callback_url
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
