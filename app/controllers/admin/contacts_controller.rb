class Admin::ContactsController < Admin::Base

  def index
    @contacts = Contact.order(date: :desc)
  end

  def inbound
    @contacts = Contact.order(date: :desc).where(contact_id: nil)
    render :index
  end

  def outbound
    @contacts = Contact.order(date: :desc).where.not(contact_id: nil)
    render :index
  end

  def show
    @contact = Contact.find(params[:id])
  end
end
