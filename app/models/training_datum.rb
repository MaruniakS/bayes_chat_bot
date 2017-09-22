class TrainingDatum < ApplicationRecord
  belongs_to :category

  validates :sentence, presence: true, uniqueness: true,
            format: { with: /\A[a-zA-z ]+\z/, message: 'Only letters are allowed' }

  scope :get_by_type, ->(category_type) { where category: category_type}
end
