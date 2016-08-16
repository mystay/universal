if defined?(Rails)
  Universal::Engine.routes.draw do
    resources :configurables do
      collection do
        post :delete
      end
    end
    resources :tags
    resources :comments
    resources :functions
    resources :flags do
      collection do
        patch :toggle
      end
    end
  end
end
