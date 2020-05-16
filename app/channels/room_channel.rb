class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data['message'],
                              user_id: current_user.id,
                              room_id: params['room_id'])
    render_message = ApplicationController.renderer.render(partial: 'messages/message',
                                                            locals: {message: message})
    ActionCable.server.broadcast 'room_channel',
                                  message: render_message,
                                  room_id: params['room_id']
  end
end