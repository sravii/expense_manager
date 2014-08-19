class RegistrationsController < Devise::RegistrationsController
  def after_update_path_for(resource)
    case resource
    when :user, User
      resource.teacher? ? another_path : root_path
    else
      super
    end
  end
end
