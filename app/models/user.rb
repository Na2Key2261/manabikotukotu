class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def is_deleted
    self[:is_deleted]
  end
  
  def guest?
    email == 'guest@example.com'
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.joins(:posts).where("posts.learning_content LIKE ?", "#{word}")
                   .or(User.joins(:posts).where("posts.learning_item LIKE ?", "#{word}"))
    elsif search == "forward_match"
      @user = User.joins(:posts).where("posts.learning_content LIKE ?", "#{word}%")
                   .or(User.joins(:posts).where("posts.learning_item LIKE ?", "#{word}%"))
    elsif search == "backward_match"
      @user = User.joins(:posts).where("posts.learning_content LIKE ?", "%#{word}")
                   .or(User.joins(:posts).where("posts.learning_item LIKE ?", "%#{word}"))
    elsif search == "partial_match"
      @user = User.joins(:posts).where("posts.learning_content LIKE ?", "%#{word}%")
                   .or(User.joins(:posts).where("posts.learning_item LIKE ?", "%#{word}%"))
    else
      @user = User.all
    end
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲストユーザー"
      user.password_confirmation = user.password
      user.password = SecureRandom.urlsafe_base64
    end
  end


end
