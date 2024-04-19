class Administrator < ApplicationRecord
  has_many :memos, dependent: :destroy
  has_many :attendances, dependent: :destroy
  
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password_digest = nil
    end
  end

  validates :code, presence: true, uniqueness: true
end
