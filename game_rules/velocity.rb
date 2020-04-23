module GameRules
  module Velocity
    extend Observable

    # also have to add this rule to scheudler
    # initializer sucks.
    module Initializer
      def initialize
        GameRules::Velocity.add_observer self, :schedule_task
        # GameRules::Gravity.add_observer self, :update_gravity
        super
      end
    end

    def self.schedule(frame_tasks)
      changed
      notify_observers frame_tasks, self
    end

    def self.update(entity)
      entity.coordinates.x += entity.vel_x
      entity.coordinates.y += entity.vel_y
      entity.coordinates.a += entity.vel_a
    end
  end
end
