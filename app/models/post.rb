class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #enum learning_item: { economic: 1, accounting: 2, management: 3, operation: 4, 
                        #legal: 5, information: 6, small: 7, 
                        #case_first: 8, case_second: 9, case_third: 10, case_fourth: 11 }
                        
  enum learning_item: { '経済学・経済政策' => 1, '財務・会計' => 2, '企業経営理論' => 3, '運営管理' => 4, 
  '経営法務' => 5, '経営情報システム' => 6, '中小企業経営・政策' => 7, 
  '事例Ⅰ' => 8, '事例Ⅱ' => 9, '事例Ⅲ' => 10, '事例Ⅳ' => 11, }
  validates :learning_item, presence: true
  validates :learning_hour, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :learning_content, presence: true

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('name LIKE ?', '%' + content)
    else
      Post.where('name LIKE ?', '%' + content + '%')
    end
  end
end