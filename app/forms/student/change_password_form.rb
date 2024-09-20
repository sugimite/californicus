class Student::ChangePasswordForm
  include ActiveModel::Model
  
  attr_accessor :object, :current_password, :new_password, :new_password_confirmation

  validates :new_password, presence: true, confirmation: true
  validate :current_password_is_correct

  def save
    return false unless valid? 
    object.password = new_password
    object.save
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message) # 保存時のエラーを追加
    false
  end

  private

  def current_password_is_correct
    unless Student::Authenticator.new(object).authenticate(current_password)
      errors.add(:current_password, :wrong)
    end
  end
end
