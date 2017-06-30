if defined?(Rails)
  Universal::Engine.routes.draw do
    resources :configurables do
      collection do
        post :delete
      end
    end
    resources :tags
    resources :attachments
    resources :countries
    resources :situations
    resources :comments do
      collection do
        get :recent
      end
    end
    resources :functions
    resources :flags do
      collection do
        patch :toggle
      end
    end
  end
end
