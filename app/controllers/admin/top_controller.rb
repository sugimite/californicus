class Admin::TopController < Admin::Base
  def index
    @unread_contacts_count = Contact.where(read: false).count
    @unread_contacts_count ||= 0
    if current_administrator
      render action: "dashboard"
    else
      render action: "index"
    end
  end
end
