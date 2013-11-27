require "fog"
require "log4r"

module VagrantPlugins
  module HP
    module Action
      # This action connects to HP, verifies credentials work, and
      # puts the HP connection object into the `:hp_compute` key
      # in the environment.
      class ConnectHP
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_hp::action::connect_hp")
        end

        def call(env)
          # Get the configs
          config   = env[:machine].provider_config
          api_key  = config.api_key
          endpoint = config.endpoint
          username = config.username
          tenant = config.tenant
          region = config.region
          version = config.version

          @logger.info("Connecting to HP...")
          env[:hp_compute] = Fog::Compute.new({
            :provider      => "HP",
            :hp_access_key  => username,
            :hp_secret_key => api_key,
            :hp_auth_uri   => endpoint,
            :hp_tenant_id => tenant,
            :hp_avl_zone => region,
            :version => version
          })

          if config.network
            env[:hp_network] = Fog::HP::Network.new({
              :provider => :hp,
              :hp_access_key  => username,
              :hp_secret_key => api_key,
              :hp_auth_uri   => endpoint,
              :hp_tenant_id => tenant,
              :hp_avl_zone => region,
              :version => version
            })
          end

          @app.call(env)
        end
      end
    end
  end
end
