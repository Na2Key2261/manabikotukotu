class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
end
