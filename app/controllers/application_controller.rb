class ApplicationController < ActionController::Base
  # before_action :delay

  def delay
    sleep(0.5)
  end

  def redirect_to_out_of_frame(location)
    render turbo_stream: helpers.tag.turbo_stream(action: "redirect", location: url_for(location))
  end
end
