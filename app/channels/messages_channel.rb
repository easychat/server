class MessagesChannel < ApplicationCable::Channel

  require "jwt_helper"
  include JwtHelper

  def user_from_token(token)
    claims = JwtHelper.decode(token) rescue nil
    return User.find_by_uuid claims['user_uuid']
  end

  def is_authorized
    token = params[:token]
    @user = user_from_token(token)
    return @user
  end

  def subscribed
    if !is_authorized
      return
    end

    stream_from room_name
    send_message({meta: true, type: "new-member", who: @user.email, sender: @user.email})
  end

  def unsubscribed
    send_message({meta: true, type: "less-member", who: @user.email, sender: @user.email})
  end

  def send_message(content)
    if !is_authorized
      return
    end

    ActionCable.server.broadcast room_name, content: content
  end

  private

  def room_name
    [@user.email, params[:recipient]].sort().join("|")
  end

end
