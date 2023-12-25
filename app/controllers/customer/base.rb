class Customer::Base < ApplicationController
  private def current_customer
    if session[:customer_id]
      @current_customer ||=
        Customer.find_by(id: session[:customer_id])
    end
  end

  helper_method :current_customer
end