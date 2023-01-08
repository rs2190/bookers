class BooksController < ApplicationController
  def new

    # インスタンス変数 [@]
    # コントローラーとViewでデータの受け渡しができる
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @book = Book.new

  end

  def create

    # データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_param)
    # データをデータベースに保存するためのsaveメソッド実行
    @book.save
    # フラッシュメッセージを定義
    flash[:notice] = 'Book was successfully created.'
    # 詳細画面へリダイレクト
    redirect_to book_path(@book.id);

  end

  def index
  end

  def show

    @book = Book.find(params[:id])

  end

  def edit
  end


  private

    # ストロングパラメータ
    def book_param

      # params
      # formから送られてくるデータはparamsの中に入っています。
      #
      # require
      # 送られてきたデータの中からモデル名(ここでは:book)を指定し、データを絞り込みます。
      #
      # permit
      # requireで絞り込んだデータの中から、保存を許可するカラムを指定します

      # params..require(:bbok).permit(:title,:body)
      # ⇒param is missing or the value is empty: が発生。
      params.permit(:title,:body)

    end

end
