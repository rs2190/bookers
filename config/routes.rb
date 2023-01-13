Rails.application.routes.draw do

  # root to:  'コントローラ名#アクション名'
  # rails立ち上げ時のアプリケーショントップ画面をルートパスに設定できる。
  root to: 'homes#top'

  resources :books

  # get 'books' => 'books#new'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
