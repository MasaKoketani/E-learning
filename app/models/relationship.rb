class Relationship < ApplicationRecord
    has_one :activity, as: :action
end
