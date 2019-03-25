class Relationship < ApplicationRecord
    belongs_to :user

    has_one :activity, as: :action
end
