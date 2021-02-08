# frozen_string_literal: true

class Child < ApplicationRecord
  has_many :chores
  has_many :tasks, through: :chores

  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }

  validates_presence_of :first_name, :last_name

  def name
    first_name + ' ' + last_name
  end

  def points_earned
    chores.done.inject(0) { |sum, chore| sum += chore.task.points }
  end
end
