BlueNavy::Application.routes.draw do
  resources :games, only: [:create, :show]
  root to: "games#index"
end
