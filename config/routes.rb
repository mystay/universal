if defined?(Rails)
  Universal::Engine.routes.draw do
    resources :configurables do
      collection do
        post :delete
      end
    end
    resources :tags
    resources :functions
  end
end
