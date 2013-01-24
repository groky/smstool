class UserController < ApplicationController
  def new
    @title = "Register"
    @user = User.new
    @user_types = UserType.all
    @lang = Language.all
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def account
  end

  def update
  end

  def detroy
  end

  def index
    @title="User List"
    @users = User.all
  end

end
