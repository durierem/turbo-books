class CanvasController < ApplicationController
  def destroy
    render html: helpers.turbo_frame_tag("canvas")
  end
end
