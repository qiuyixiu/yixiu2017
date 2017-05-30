Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root 'welcome#index'
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  namespace :admin do
    resources :products do
      member do
        post :publish
        post :hide
      end
    end
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
    resources :categories
  end

  resources :products do
    member do
      post :add_to_cart
    end
    collection do
      get :search
    end
    member do
      post :favorite
      post :unfavorite
    end
    resources :comments
  end

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  resources :cart_items

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
    resources :users
  end

  resources :favorites
end
