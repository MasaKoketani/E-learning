class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category


  has_many :answers
  has_many :questions, through: :answers
  has_many :choices, through: :answers

  def next_question
    (category.questions - questions).first
  end
end
