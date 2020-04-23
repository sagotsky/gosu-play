require "forwardable"
require "rubygems"
require "bundler/setup"
require "observer"
Bundler.require :default

%w[
  coordinates
  frame_tasks
  game_window
  input
  game_rules/gravity
  game_rules/terminal_velocity
  game_rules/velocity
  game_rules/floor

  player
].each { |source| require "./#{source}.rb" }

GameWindow.new.show
