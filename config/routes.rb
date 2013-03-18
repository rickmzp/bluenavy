BlueNavy::Application.routes.draw do
  resources :games, only: [:create, :show] do
    post :join, on: :member
  end
  root to: "games#index"
end
