class MessagesChannel < ApplicationCable::Channel

  require "jwt_helper"
  include JwtHelper

  def user_from_token(token)
    claims = JwtHelper.decode(token) rescue nil
    return User.find_by_uuid claims['user_uuid']
  end

  def is_authorized
    token = params[:token]
    user = user_from_token(token)
    if !user
      return false
    end
    participants = params[:room].split("|")
    return participants.include?(user.email)
  end

  def subscribed
    if !is_authorized
      return
    end

    stream_from params[:room]
  end

  def unsubscribed

  end

  def send_message(data)
    if !is_authorized
      return
    end

    ActionCable.server.broadcast params[:room], payload: data
  end

end
