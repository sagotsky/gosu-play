module GameRules
  module TerminalVelocity
    extend Observable

    module Initializer
      def initialize
        GameRules::TerminalVelocity.add_observer self, :schedule_task
        # GameRules.Gravity.add_observer self, :update_gravity
        super
      end
    end

    def self.schedule(frame_tasks)
      changed
      notify_observers frame_tasks, self
    end

    def self.update(entity)
      if entity.x > 0
        entity.coordinates.x = [entity.x, entity.terminal_velocity].max
      else
        entity.coordinates.x = [entity.x, -1 * entity.terminal_velocity].min
      end

      if entity.y > 0
        entity.coordinates.y = [entity.y, entity.terminal_velocity].max
      else
        entity.coordinates.y = [entity.y, -1 * entity.terminal_velocity].min
      end
    end
  end
end
