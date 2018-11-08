class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
  end
end
