# frozen_string_literal: true

class Expense < ApplicationRecord
  DEFAULT_LIMIT = 20

  belongs_to :category
  belongs_to :user

  enum status: %w[hidden shared]

  validates :amount, presence: true
  validates :category_id, presence: true

  scope :by_shared_group_user_category, lambda { |limit = DEFAULT_LIMIT|
                                          shared
                                            .order(updated_at: :desc)
                                            .limit(limit)
                                            .group_by(&:user)
                                        }
end
