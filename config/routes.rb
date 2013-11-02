Kayessess::Engine.routes.draw do
  root :to => 'styleguides#show'

  resources :sections, only: [:index, :show] do
    get 'example', on: :member
  end
end
