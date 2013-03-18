BlueNavy::Application.routes.draw do
  resources :games, only: [:create, :show] do
    member do
      post :join
      post :ready_to_play
    end
  end

  scope "games/:game_id" do
    resource :navy, only: [] do
      post :auto_deploy, on: :collection
      resource :attacks
    end
  end

  resource :session, only: [:new, :create, :destroy]

  root to: "games#index"
end
