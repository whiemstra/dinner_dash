Paperclip.interpolates(:placeholder) do |attachment, style|
  # TODO ActionController::Base.helpers.asset_path("missing_#{style}.png")
  ActionController::Base.helpers.asset_path("111.jpg")
end
