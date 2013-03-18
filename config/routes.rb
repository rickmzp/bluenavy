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
    end
  end

  root to: "games#index"
end
