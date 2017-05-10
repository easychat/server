Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  scope :path => "auth" do
    get 'status' => "auth#status"
    post "sign_in" => "auth#sign_in"
    post "/" => "auth#register"
  end

end
