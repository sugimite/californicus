class Admin::StudentSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :school_grade, :string
  attribute :name_kana, :string

  def search(scope)
    scope = scope.search_by_name(name)
    scope = scope.search_by_school_grade(school_grade)
    scope = scope.where("name_kana LIKE ?", "%#{name_kana}%") if name_kana.present?
    scope
  end
end
