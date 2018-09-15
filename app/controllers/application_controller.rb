class ApplicationController < ActionController::Base
  before_action :set_customers

  # Load Customers for navbar links.
  def set_customers
    @customers ||= Customer.all.order_by(name: :asc)
  end
end
