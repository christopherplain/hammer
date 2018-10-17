class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_customers
  layout :layout_by_resource

  private
    # Load Customers for navbar links.
    def set_customers
      @customers ||= Customer.all.order(name: :asc)
    end

    def layout_by_resource
      if devise_controller?
        "user"
      else
        "application"
      end
    end

    # Determine if current user is a member of the admin group.
    def verify_admin!
      unless current_user.admin?
        flash[:alert] = t("devise.failure.restricted", url: request.original_fullpath)
        redirect_to root_path
      end
    end
end
