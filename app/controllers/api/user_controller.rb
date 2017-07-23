class Api::UserController < ApplicationController
  # before_action :check_token

  def index
    @users = User.all.order('id DESC')
  end

  def show
    @user = User.find(params[:id])
  end


  
end
