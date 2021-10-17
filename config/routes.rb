Rails.application.routes.draw do
  root to: 'home#index'

  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
    resource :user, only: %i[show update]

    resource :category, only: %i[index] do
      collection do
        get 'all' => :index
      end
    end

    resource :company do
      collection do
        get 'all' => :index
      end
    end

    resource :reviews do
      collection do
        get 'all' => :index
        post :vote
        post :spam
      end
    end
  end
end
