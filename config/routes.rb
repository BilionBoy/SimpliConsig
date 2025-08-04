Rails.application.routes.draw do
  root 'admin#index'
  get 'admin/index'
  get 'admin/new'
  get 'admin/clientes'
  get 'admin/contratos'
  get 'admin/show'
  get 'admin/edit'
  get 'home/index'

  # Rotas Scaffold

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
