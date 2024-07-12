class Admin::AjaxController < ApplicationController
  before_action :check_source_ip_address
  before_action :authorize
  before_action :check_timeout

  def contact_count
    render plain: StudentContact.unprocessed.count
  end

  private def check_source_ip_address
    unless AllowedSource.include?("admin", request.ip)
      render plain: "Forbidden", status: 403
    end
  end

  private def current_admin_member
    if session[:admin_member_id]
      AdminMember.find_by(id: session[:admin_member_id])
    end
  end

  private def authorize
    unless current_admin_member && current_admin_member.active?
      render plain: "Forbidden", status: 403
    end
  end
  
  private def check_timeout
    unless session[:last_access_time] &&
           session[:last_access_time] >= Admin::Base::TIMEOUT.ago
      session.delete(:admin_member_id)
      render plain: "Forbidden", status: 403
    end
  end
end
