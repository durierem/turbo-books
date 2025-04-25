module ApplicationHelper
  def turbo_frame_tag_with_loader(id, **args)
    turbo_frame_tag(id, **args, class: "d-flex justify-content-center w-100 p-5") do
      content_tag(:span, nil, class: "spinner-border", role: "status")
    end
  end
end
