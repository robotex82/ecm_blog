Ecm::Blog::Engine.routes.draw do
  localized do
    scope :ecm_blog_engine do
      resources :posts, only: [:index, :show]

      root to: 'posts#index'
    end
  end
end
