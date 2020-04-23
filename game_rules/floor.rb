module GameRules
  module Floor
    extend Observable

    # also have to add this rule to scheudler
    # initializer sucks.
    module Initializer
      def initialize
        GameRules::Floor.add_observer self, :schedule_task
        # GameRules::Gravity.add_observer self, :update_gravity
        super
      end
    end

    def self.schedule(frame_tasks)
      changed
      notify_observers frame_tasks, self
    end

    def self.update(unicorn)
      if unicorn.y > 450
        unicorn.coordinates.y = 450.0
        unicorn.coordinates.vel_y = 0
      end
    end
  end
end

