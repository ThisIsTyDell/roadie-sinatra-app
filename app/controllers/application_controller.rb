require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "mic_check"
  end  
  
  get '/' do
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end

end