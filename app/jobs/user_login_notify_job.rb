# frozen_string_literal: true

class UserLoginNotifyJob < ApplicationJob
  queue_as :default

  def perform(message)
    sleep 10
    puts '-' * 30
    puts "here!! #{message}"
    puts '-' * 30
  end
end
