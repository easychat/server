require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EasyServer
  class Application < Rails::Application

      config.active_record.primary_key = :uuid

      config.generators do |g|
        g.orm :active_record, primary_key_type: :uuid
      end
  end
end