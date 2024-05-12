# == Schema Information
#
# Table name: administrators
#
#  id              :bigint           not null, primary key
#  password_digest :string
#  code            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_administrators_on_code  (code) UNIQUE
#
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
