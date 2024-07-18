class Admin::ContactsController < Admin::Base
  def index
    @contacts = Contact.order(date: :desc).includes(:student)
  end
end
