class Search < ApplicationRecord
  validates :search_text, presence: true
  validates :search_count, presence: true, numericality: { greater_than: 0 }
  after_commit -> { SearchRelayJob.perform_later(self) }
end
