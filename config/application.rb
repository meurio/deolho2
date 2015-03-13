require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'rack-cas/session_store/active_record'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Legislando
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = "pt-BR"

    config.rack_cas.server_url = ENV['CAS_SERVER_URL']
    config.rack_cas.session_store = RackCAS::ActiveRecordStore

    config.active_record.raise_in_transactional_callbacks = true

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :user_name => ENV["SENDGRID_USERNAME"],
      :password => ENV["SENDGRID_PASSWORD"],
      :domain => "legislando.nossascidades.org",
      :address => "smtp.sendgrid.net",
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  end
end
