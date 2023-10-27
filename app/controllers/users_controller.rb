class UsersController < ApplicationController

before_action :is_matching_login_user, only: [:edit, :update]


    # データを受け取り新規登録するためのインスタンス作成
  def new
    @user = User.new
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  #@userはUserモデルから特定のユーザー取得
  #.booksメソッドで@userに関する本を全て取得して＠booksに代入
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "error"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end