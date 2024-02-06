class Post < ApplicationRecord
  belongs_to :user

  enum learning_item: { '経済学・経済政策' => 1, '財務・会計' => 2, '企業経営理論' => 3, '運営管理' => 4, 
                        '経営法務' => 5, '経営情報システム' => 6, '中小企業経営・政策' => 7, 
                        '事例Ⅰ' => 8, '事例Ⅱ' => 9, '事例Ⅲ' => 10, '事例Ⅳ' => 11, }
  validates :learning_item, presence: true
  validates :learning_hour, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :learning_content, presence: true
end