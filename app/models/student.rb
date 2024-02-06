class Student < ApplicationRecord
  include StringNormalizer

  before_validation do
    self.name = normalize_as_name(name)
    self.name_kana = normalize_as_kana(name_kana)
    self.email = normalize_as_email(email)
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password_digest = nil
    end
  end

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :name, presence: true
  validates :name_kana, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true }
  validates :email, uniqueness: { sensitive: false }
end
