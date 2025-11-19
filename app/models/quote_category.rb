class QuoteCategory < ApplicationRecord
  belongs_to :quote
  belongs_to :category

  # validates :quote_id, presence: true
  # validates :category_id, presence: true
end
