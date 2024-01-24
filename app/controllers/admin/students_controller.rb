class Admin::StudentsController < Admin::Base
  def index
    @students = Student.order(:name_kana)
  end
end
