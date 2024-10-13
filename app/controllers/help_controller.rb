class HelpController < ApplicationController
  def show
    render params[:page], layout: "help"
  end

  def destroy
    render html: helpers.turbo_frame_tag("help")
  end
end
