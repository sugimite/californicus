class Customer::TopController < Customer::Base
  def index
    render action: "index"
  end
end
