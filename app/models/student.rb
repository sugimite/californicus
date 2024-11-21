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
  has_many :absences, dependent: :destroy

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

  GRADES = [
    ["小1", 7],
    ["小2", 8],
    ["小3", 9],
    ["小4", 10],
    ["小5", 11],
    ["小6", 12],
    ["中1", 13],
    ["中2", 14],
    ["中3", 15],
    ["高1", 16],
    ["高2", 17],
    ["高3", 18]
  ].freeze
  
  def school_grade
    grade = GRADES.find { |_, age_value| age_value == age }
    grade ? grade[0] : "#{age}歳"
  end
  
  scope :search_by_name, ->(name) { where('name LIKE ?', "%#{name}%") if name.present? }

  # 仮名で部分一致検索
  scope :search_by_name_kana, ->(name_kana) { where('name_kana LIKE ?', "%#{name_kana}%") if name_kana.present? }

  # 学年で検索
  scope :search_by_school_grade, ->(grade) {
    return if grade.blank?

    today = Date.today
    school_year_start = Date.new(today.year, 4, 1)
    school_year_start = Date.new(today.year - 1, 4, 1) if today < school_year_start

    # 年齢計算（SQL）
    birth_year_lower = school_year_start.year - grade.to_i    # 学年の下限
    birth_year_upper = school_year_start.year - grade.to_i + 1   # 学年の上限

    where("EXTRACT(MONTH FROM birthday) BETWEEN 1 AND 3") \
    .where("EXTRACT(YEAR FROM birthday) = ?", birth_year_upper)
    .or(where("EXTRACT(MONTH FROM birthday) NOT BETWEEN 1 AND 3")
          .where("EXTRACT(YEAR FROM birthday) = ?", birth_year_lower))
  }

  def age
    if birthday
      today = Date.today
      school_year_start = Date.new(today.year, 4, 1)

      school_year_start = Date.new(today.year - 1, 4, 1) if today < school_year_start
  
      age = school_year_start.year - birthday.year
  
      age += 1 if birthday.month <= 3
  
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

  def absences_in_month(year, month)
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, -1)
    absences.where(absent_on: start_date..end_date).sum(:count)
  end

  def absences_for_year(year)
    start_date = Date.new(year, 3, 1)
    end_date = Date.new(year + 1, 2, Date.leap?(year + 1) ? 29 : 28)
    
    absences.where(absent_on: start_date..end_date).sum(:count)
  end

  def current_school_year
    today = Date.today
    today.year - (today.month < 3 ? 1 : 0)
  end
end
