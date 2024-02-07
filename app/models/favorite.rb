class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  def favorite_for(user)
    post.favorites.exists?(user_id: user.id)
  end
end
