class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post_image = XXX
  end
  
  
end
