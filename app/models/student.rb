class Student < ApplicationRecord
  include StringNormalizer

  before_validation do
    self.name = normalize_as_name(name)
    self.name_kana = normalize_as_kana(name_kana)
    self.email = normalize_as_email(email)
  end

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :name, presence: true
  validates :name_kana, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true }
  validates :email, presence: true, "valid_email2/email": true, uniqueness: { case_sensitive: false }

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password_digest = nil
    end
  end

  def age
    if self.birthday?
      age = Date.today.year - self.birthday.year 
      if self.birthday.month < 4 || Date.today.month < 4
        age -= 1 
      end
      return age
    end
  end
end
