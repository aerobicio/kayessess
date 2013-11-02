Kayessess::Engine.routes.draw do
  root :to => 'styleguides#show'

  resources :sections, only: [:index, :show], constraints: { id: /.+/ } do
    get 'example', on: :member
  end
end
