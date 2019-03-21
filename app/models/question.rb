class Question < ApplicationRecord
  belongs_to :category
  has_many :choices
  accepts_nested_attributes_for :choices

  validates :content, presence: true

  validate :check_correct

  private
    def check_correct
      c = choices.collect { |choice| choice.correct || nil }

      if c.compact.size != 1
          errors.add(:correct, "should only have 1 checked")
      end
    end
end
