module ApplicationHelper
  def flash_class(name)
    case name
      when "success" then "alert alert-success"
      when "alert" then "alert alert-danger"
      when "error" then "alert alert-warning"
      when "notice" then "alert alert-info"
    end
  end
end
