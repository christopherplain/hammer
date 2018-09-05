class ApplicationController < ActionController::Base
  before_action :set_customers

  def set_customers
    @customers ||= Customer.all.order_by(name: :asc)
  end
end
