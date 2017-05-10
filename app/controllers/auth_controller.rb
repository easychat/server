class AuthController < ApplicationController
  require "jwt_helper"
  include JwtHelper

  before_action {
    @user = User.find_by_email(params[:email])
  }

  def status
    if @user
      render :json => {:status => "registered"}
    else
      render :json => {:status => "not_found"}
    end
  end

  def sign_in
    if @user && test_password(params[:password], @user.encrypted_password) == true
      render :json => {:user => @user, :token => jwt(@user)}
    else
      render :json => {:error => {:message => "Invalid email or password."}}, :status => 401
    end
  end

  def register
    if @user
      render :json => {:error => {:message => "Already registered"}}, :status => 401
    else
      @user = User.new
      @user.email = params[:email]
      @user.encrypted_password = hash_password(params[:password])
      @user.save
      render :json => {:user => @user, :token => jwt(@user)}
    end
  end

  private

  require "bcrypt"

  DEFAULT_COST = 10

  def hash_password(password)
    BCrypt::Password.create(password, cost: DEFAULT_COST).to_s
  end

  def test_password(password, hash)
    bcrypt = BCrypt::Password.new(hash)
    password = BCrypt::Engine.hash_secret(password, bcrypt.salt)
    return password == hash
  end

  def jwt(user)
    JwtHelper.encode({:user_uuid => user.uuid, :pw_hash => Digest::SHA256.hexdigest(user.encrypted_password)})
  end

end
