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

  def generate_password_token!
    self.password_reset_token = generate_token
    self.password_reset_token_expire = Time.now.utc
    save!

    self.password_reset_token
  end

  def password_token_valid?
    (self.password_reset_token_expire + 24.hours) > Time.now.utc
  end

  def reset_password!(password_params)
    self.password_reset_token = nil
    self.password = password_params[:password]
    self.password_confirmation = password_params[:password_confirmation]

    save!
  end

  private

  def generate_token
    SecureRandom.hex(20)
  end
end
