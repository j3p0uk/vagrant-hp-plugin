require "vagrant"

module VagrantPlugins
  module HP
    module Errors
      class VagrantHPError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_hp.errors")
      end

      class CreateBadState < VagrantHPError
        error_key(:create_bad_state)
      end

      class NoMatchingFlavor < VagrantHPError
        error_key(:no_matching_flavor)
      end

      class NoMatchingImage < VagrantHPError
        error_key(:no_matching_image)
      end

      class RsyncError < VagrantHPError
        error_key(:rsync_error)
      end

      class SSHNoValidHost < VagrantHPError
        error_key(:ssh_no_valid_host)
      end

      class FloatingIPNotValid < VagrantHPError
        error_key(:floating_ip_not_valid)
      end
    end
  end
end
