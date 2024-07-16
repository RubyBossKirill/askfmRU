class Question < ApplicationRecord
    belongs_to :user
    validates :body, presence: true
    validates :title, length: { maximum: 124 }
    COLOR = [['Красный', 'rgba(255, 87, 51, 0.7)'],
    ['Зелёный', 'rgba(51, 255, 87, 0.7)'],
    ['Голубой', 'rgba(51, 87, 255, 0.7)'],
    ['Розовый', 'rgba(255, 51, 161, 0.7)'],
    ['Оранжевый', 'rgba(255, 191, 51, 0.7)']]
end
