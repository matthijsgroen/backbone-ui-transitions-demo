UiDemo::Application.routes.draw do

  resources :product_categories, path: 'categories' do
    resources :products do
      get 'details' => 'products#details'
    end
  end

  root to: 'product_categories#index'
end
