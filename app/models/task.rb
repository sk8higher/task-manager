class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine :state, initial: :new_task do
    event :start_development do
      transition new_task: :in_development
    end

    event :start_qa do
      transition in_development: :in_qa
    end

    event :return_tested_to_development do
      transition in_qa: :in_development
    end

    event :start_code_review do
      transition in_qa: :in_code_review
    end

    event :mark_ready_for_release do
      transition in_code_review: :ready_for_release
    end

    event :return_reviewed_to_development do
      transition in_code_review: :in_development
    end

    event :release do
      transition ready_for_release: :released
    end

    event :archive do
      transition [:new_task, :in_development, :in_qa, :in_code_review, :ready_for_release, :released] => :archived
    end
  end
end
