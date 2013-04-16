UiDemo::Application.routes.draw do

  resources :product_categories, path: 'categories' do
    resources :products
  end

  root to: 'product_categories#index'
end
