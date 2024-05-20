class Admin::GradesController < Admin::Base
  def index
    @grades = Grade.order(year: :desc).includes(:student)
  end
  
end
