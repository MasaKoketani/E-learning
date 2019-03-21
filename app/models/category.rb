class Category < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :content, presence: true

    has_many :questions
    accepts_nested_attributes_for :questions
end
