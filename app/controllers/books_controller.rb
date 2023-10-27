class BooksController < ApplicationController

before_action :is_matching_login_user, only: [:edit, :update]

def index
  # データを受け取り新規登録するためのインスタンス作成
  @book = Book.new
  @books = Book.all
end

def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    render:index
  end
end

#@userはURLから取得したパラメータを元にユーザーのIDを取得する。
#.booksメソッドで@userに関する本を全て取得して＠booksに代入
def show
  @book = Book.find(params[:id])
  @user = @book.user
  @book_new = Book.new
end
#特定の本を取得し、その本に関連付けられたユーザーオブジェクトを@user変数に設定して、
#@userに関連する本のコレクションを@books変数に設定する。
def edit
  @book = Book.find(params[:id])
  @user = @book.user
  @books = @user.books
end

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "successfully"
    redirect_to book_path(@book)
  else
    flash.now[:alert] = "error"
    render :edit # 編集フォームを再表示
  end
end

def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
end


  private

def book_params
  params.require(:book).permit(:title, :body, :profile_image)
end
end

def is_matching_login_user
  book = Book.find(params[:id])
  unless book.user.id == current_user.id
    redirect_to books_path
  end
end