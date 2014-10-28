class ApplicationController < ActionController::Base
  protect_from_forgery
  Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
end
