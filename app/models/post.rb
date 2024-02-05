class Post < ApplicationRecord
  belongs_to :user

enum learning_item: { '選択1' => 1, '選択2' => 2, '選択3' => 3 }
  validates :learning_item, presence: true
  validates :learning_hour, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :learning_content, presence: true
end