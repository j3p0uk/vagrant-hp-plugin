require "log4r"

module VagrantPlugins
  module HP
    module Action
      # This action reads the state of the machine and puts it in the
      # `:machine_state_id` key in the environment.
      class ReadState
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_hp::action::read_state")
        end

        def call(env)
          env[:machine_state_id] = read_state(env[:hp_compute], env[:machine])

          @app.call(env)
        end

        def read_state(hp, machine)
          return :not_created if machine.id.nil?

          # Find the machine
          server = hp.servers.get(machine.id)
          if server.nil? || server.state == "DELETED"
            # The machine can't be found
            @logger.info("Machine not found or deleted, assuming it got destroyed.")
            machine.id = nil
            return :not_created
          end

          # Return the state
          return server.state.downcase.to_sym
        end
      end
    end
  end
end
