class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :author, optional: true

  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories  

  # Allows to create or update author when creating/updating a quote
  # Don't create an author if both name and last name are blank
  # Proc is a ruby block of code that returns true or false 
  accepts_nested_attributes_for :author, 
    reject_if: proc { |attrs| attrs['fname'].blank? && attrs['lname'].blank? },
    allow_destroy: true
  
  accepts_nested_attributes_for :quote_categories,
    reject_if: proc { |attrs| attrs['category_id'].blank? },
    allow_destroy: true

  # Returns only quotes, where public is true
  scope :public_quotes, -> { where(is_public: true) }
  # Returns quotes ordered by the newest to the oldest, limited to only 10 quotes
  scope :latest, ->(limit = 10) { order(created_at: :desc).limit(limit) }

  # Validations: text and at least one category are required
  validates :text, presence: true
  validate :must_have_at_least_one_category

  # Validations: all chosen categories must be unique, no duplication is allowed
  validate :categories_must_be_unique

  # Method to check if at least one category is selected
  def must_have_at_least_one_category
    # - reject(&:marked_for_destruction?) filters out any categories being deleted
    # - This is important for when editing a quote - if we remove all categories, we need to catch that
    if categories.empty? && quote_categories.reject(&:marked_for_destruction?).empty?
      errors.add(:base, "Must select at least one category")
    end
  end

  # Method to check if all selected categories are unique (no duplicates)
  def categories_must_be_unique
    # Get all category_ids that aren't marked for destruction
    category_ids = quote_categories.reject(&:marked_for_destruction?).map(&:category_id).compact
    
    # - category_ids.size - Total number of category_ids
    # - category_ids.uniq.size - Number of unique category_ids (duplicates removed)
    # - If these numbers are different, we have duplicates
    # Example: [1, 2, 2, 3] has size 4, but [1, 2, 3] (after uniq) has size 3
    if category_ids.size != category_ids.uniq.size
      errors.add(:base, "Cannot select the same category multiple times")
    end
  end
end
