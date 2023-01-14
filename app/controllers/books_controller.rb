class BooksController < ApplicationController

  def create

    # データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_param)

    # データをデータベースに保存するためのsaveメソッド実行
    if @book.save

     # フラッシュメッセージを定義
     notice('Book was successfully created.')
     # 詳細画面へリダイレクト
     redirect_book_path(@book.id)

    else

      @books = book_all
      render :index

    end

  end

  def index

    # allメソッドで、booksテーブルに保存されてる全データを取得
    # booksテーブルのidで昇順
    @book = Book.new
    @books = book_all

  end

  def show

    # booksテーブルのidをキーにして、select。（1件取得）。
    @book = book_find

  end

  def edit

    # booksテーブルのidをキーにして、select。（1件取得）。
    @book = book_find

  end

  def update

    # booksテーブルのidをキーにして、select。（1件取得）。
    @book = Book.find(params[:id])
    # 編集画面の入力内容を更新する。
    if @book.update(book_param)
      # フラッシュメッセージを定義
      notice('Book was successfully updated.')
      # 詳細画面へリダイレクト
      redirect_book_path(@book.id)
    else

       render :edit

    end

  end

  def destroy

    # booksテーブルのidをキーにして、select。（1件取得）。
    book = book_find
    # 取得したデータを削除
    book.destroy
    # フラッシュメッセージを定義
    notice('Book was successfully destroyed.')
    # 詳細画面へリダイレクト
    redirect_to '/books'

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

      # params.permit(:title,:body)
      # ⇒バリデーション実装時は不要。それまではこれで。

       params.require(:book).permit(:title,:body)

    end

    # フラッシュメッセージを定義
    def notice(word)

      flash[:notice] = word

    end

    # booksテーブルのidをキーにして、select。（1件取得）。
    def book_find

      Book.find(params[:id])

    end

    # 詳細画面へリダイレクト。
    def redirect_book_path(id)

      redirect_to book_path(id)

    end

    # allメソッドで、booksテーブルに保存されてる全データを取得
    def book_all

      # booksテーブルのidで昇順
      Book.all.order(id: "ASC")

    end


end
