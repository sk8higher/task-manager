class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  def self.ransackable_attributes(auth_object = nil)
    ['assignee_id', 'author_id', 'created_at', 'description', 'expired_at', 'id', 'name', 'state', 'updated_at']
  end
end
