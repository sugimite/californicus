class Admin::Authenticator
  def initialize(administrator)
    @administrator = administrator
  end

  def authenticate(raw_password)
    @administrator &&
      @administrator.password_digest &&
      BCrypt::Password.new(@administrator.password_digest) == raw_password
  end
end
