class ApplicationController < ActionController::Base
  # before_action :delay

  def delay
    sleep(0.5)
  end
end
