# == Schema Information
#
# Table name: students
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  name_kana           :string           not null
#  birthday            :date
#  email               :string           not null
#  password_digest     :string
#  registration_date   :date             not null
#  cancellation_date   :date
#  forgetting_hw_count :integer
#  has_deposited_phone :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Student < ApplicationRecord

  has_many :memos, dependent: :destroy
  has_many :grades, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :homeworks, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :announcement_students, dependent: :destroy
  has_many :announcements, through: :announcement_students
  has_many :homework_forgets, dependent: :destroy

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

  def school_grade
    case age
    when 7
      "小1"
    when 8
      "小2"
    when 9
      "小3"
    when 10
      "小4"
    when 11
      "小5"
    when 12
      "小6"
    when 13
      "中1"
    when 14
      "中2"
    when 15
      "中3"
    when 16
      "高1"
    when 17
      "高2"
    when 18
      "高3"
    else
      "#{age}歳"
    end
  end

  def age

    if birthday
      today = Date.today
      current_year_start = Date.new(today.year, 1, 1)
      school_year_start = Date.new(today.year, 4, 1)
      
      age = today.year - birthday.year
      
      if today < school_year_start
        school_year_start = Date.new(today.year - 1, 4, 1)
      end

      if birthday >= school_year_start
        age -= 1
      end
  
      age
    end
  end

  def homework_forgets_in_month(year, month)
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, -1)
    homework_forgets.where(forgetted_on: start_date..end_date).sum(:count)
  end  

  def homework_forgets_in_year(year)
    start_date = Date.new(year, 3, 1)
    end_date = Date.new(year + 1, 2, Date.leap?(year + 1) ? 29 : 28)
    
    homework_forgets.where(forgetted_on: start_date..end_date).sum(:count)
  end  
end
