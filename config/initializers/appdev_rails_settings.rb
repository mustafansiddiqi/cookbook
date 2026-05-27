Rails.application.configure do
  config.action_controller.raise_on_open_redirects = false

  config.content_security_policy do |policy|
    policy.frame_ancestors :self, "https://envoy.fyi"
  end
end

Rails.application.config.action_controller.default_protect_from_forgery = true
Rails.application.config.active_record.belongs_to_required_by_default = true
