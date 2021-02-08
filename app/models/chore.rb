# frozen_string_literal: true

class Chore < ApplicationRecord
  belongs_to :child
  belongs_to :task

  validates_date :due_on

  scope :upcoming, -> { where('due_on >= ?', Date.current) }
  scope :past, -> { where('due_on < ?', Date.current) }
  scope :pending, -> { where.not(completed: true) }
  scope :done, -> { where(completed: true) }
  scope :chronological, -> { order('due_on, completed') }
  scope :by_task, -> { joins(:task).order('tasks.name') }

  def status
    return 'Completed' if completed

    'Pending'
  end
end
