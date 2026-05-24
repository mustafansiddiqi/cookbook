class ApplicationPolicy < ActionPolicy::Base
  authorize :user, allow_nil: true

  private

  def owner?
    user.present? && user == record.try(:user)
  end

  def authenticated?
    user.present?
  end
end
