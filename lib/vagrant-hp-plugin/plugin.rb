begin
  require "vagrant"
rescue LoadError
  raise "The HP Cloud provider must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < "1.1.0"
  raise "HP Cloud provider is only compatible with Vagrant 1.1+"
end

module VagrantPlugins
  module HP
    class Plugin < Vagrant.plugin("2")
      name "HP Cloud"
      description <<-DESC
      This plugin enables Vagrant to manage machines in HP Cloud.
      DESC

      config(:hp, :provider) do
        require_relative "config"
        Config
      end

      provider(:hp, parallel: true) do
        # Setup some things
        HP.init_i18n
        HP.init_logging

        # Load the actual provider
        require_relative "provider"
        Provider
      end
    end
  end
end
