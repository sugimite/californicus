class Admin::LoginForm
  include ActiveModel::Model

  attr_accessor :code, :password
end
