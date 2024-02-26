class Student::Authenticator
  def initialize(student)
    @student = student
  end

  def authenticate(raw_password)
    @student &&
      @student.password_digest &&
      BCrypt::Password.new(@student.password_digest) == raw_password
  end
end
