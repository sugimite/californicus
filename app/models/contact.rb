# == Schema Information
#
# Table name: contacts
#
#  id              :bigint           not null, primary key
#  student_id      :bigint           not null
#  contact_id      :integer          not null
#  messages        :text             not null
#  title           :string           not null
#  date            :datetime         not null
#  is_from_parents :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_contacts_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class Contact < ApplicationRecord
  belongs_to :student

  validates :messages, presence: true
  validates :title, presence: true
end
