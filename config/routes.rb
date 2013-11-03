Kayessess::Engine.routes.draw do
  root :to => 'sections#index'

  resources :sections, only: [:show], constraints: { id: /.+/ }, :path => '' do
    get 'example', on: :member
  end
end
