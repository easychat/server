class ApplicationController < ActionController::Base
  respond_to :json

  protect_from_forgery with: :null_session

  before_action {
    request.env['HTTP_ACCEPT_ENCODING'] = 'gzip'
  }

end
