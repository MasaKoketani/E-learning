class Answer < ApplicationRecord
    belongs_to :choice
    belongs_to :lesson
    belongs_to :question
end
