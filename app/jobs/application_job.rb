class ApplicationJob < ActiveJob::Base
  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: render_message(message)
  end
end
