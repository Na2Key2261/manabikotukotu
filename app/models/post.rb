class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  enum learning_item: { '経済学・経済政策' => 1, '財務・会計' => 2, '企業経営理論' => 3, '運営管理' => 4, 
                        '経営法務' => 5, '経営情報システム' => 6, '中小企業経営・政策' => 7, 
                        '事例Ⅰ' => 8, '事例Ⅱ' => 9, '事例Ⅲ' => 10, '事例Ⅳ' => 11, }
  validates :learning_item, presence: true
  validates :learning_hour, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :learning_content, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end