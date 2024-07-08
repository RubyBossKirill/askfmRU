class Question < ApplicationRecord
    belongs_to :user
    validates :body, presence: true
    validates :title, length: { maximum: 124 }
end
