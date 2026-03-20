class ApplicationController < ActionController::Base
  # before_action :delay

  def delay
    sleep(0.5)
  end

  def stream_redirect_to(location)
    render turbo_stream: helpers.tag.turbo_stream(action: "redirect", location: url_for(location))
  end
end
