class Student < ApplicationRecord

  has_many :memos, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :attendances, dependent: :destroy

  
  include StringNormalizer

  before_validation do
    self.name = normalize_as_name(name)
    self.name_kana = normalize_as_kana(name_kana)
    self.email = normalize_as_email(email)
  end

  KATAKANA_REGEXP = /\A(?:[ァ-ヶ]|[\uFF65-\uFF9F])+(\s(?:[ァ-ヶ]|[\uFF65-\uFF9F])+)*\z/

  validates :name, presence: true
  validates :name_kana, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true } 
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: { case_sensitive: false }

  def password=(raw_password)

    if raw_password.kind_of?(String)
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password_digest = nil
    end

  end

  def age

    if birthday?
      age = Date.today.year - birthday.year 

      if birthday.month < 4 || Date.today.month < 4
        age -= 1 
      end

      age
    end

  end
end
