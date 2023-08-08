class User < ApplicationRecord
  has_secure_password

  has_many :my_tasks, class_name: 'Task', foreign_key: :author_id
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id

  validates :first_name, length: { minimum: 2 }, presence: true
  validates :last_name, length: { minimum: 2 }, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@.+\.\S+\z/ }

  def self.ransackable_attributes(_auth_object = nil)
    ['email', 'first_name', 'id', 'last_name', 'type']
  end
end
