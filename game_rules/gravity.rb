module GameRules
  module Gravity
    include Observable
    extend Observable

    module Initializer
      def initialize
        GameRules::Gravity.add_observer self, :schedule_task
        # GameRules::Gravity.add_observer self, :update_gravity
        super
      end
    end


    def self.schedule(frame_tasks)
      changed
      notify_observers frame_tasks, self
    end

    def self.update(entity)
      entity.coordinates.vel_y += 1.0
    end
  end
# def update_gravity(value)
#   puts "updating gravity #{@vel_x}"
#   @vel_y -= value
# end

# def initialize
#   puts 'adding'
#   binding.pry
#   add_observer(GameRules::Gravity, :update_gravity)

#   super
# end
end
