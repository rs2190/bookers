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
    notice
    # 詳細画面へリダイレクト
    redirect_book_path(@book.id)

  end

  def index

    # allメソッドで、booksテーブルに保存されてる全データを取得
    # booksテーブルのidで昇順
    @books = Book.all.order(id: "ASC")

  end

  def show

    # booksテーブルのidをキーにして、select。
    @book = book_find

  end

  def edit

    # booksテーブルのidをキーにして、select。
    @book = book_find

  end

  def update

    # booksテーブルのidをキーにして、select。
    book = Book.find(params[:id])
    # 編集画面の入力内容を更新する。
    book.update(book_param_update)
    # フラッシュメッセージを定義
    notice
    # 詳細画面へリダイレクト
    redirect_book_path(book.id)


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

      # params.require(:book).permit(:title,:body)
      # ⇒param is missing or the value is empty: が発生。
      # ⇒require(:book)を削除したら出来た。
      # (https://qiita.com/Takka_Log/items/32dae78d7e3892e7b051)
      params.permit(:title,:body)

    end

    # ストロングパラメータ_更新用
    def book_param_update

      params.require(:book).permit(:title,:body)

    end

    # フラッシュメッセージを定義
    def notice

      flash[:notice] = 'Book was successfully created.'

    end

    # booksテーブルのidをキーにして、select。
    def book_find

      Book.find(params[:id])

    end

    # 詳細画面へリダイレクト。
    def redirect_book_path(id)

      redirect_to book_path(id)

    end


end
