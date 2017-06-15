Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'registrations',
      sessions: 'sessions'
    },
    path_names: {
      sign_in:  'login',
      sign_out: 'logout',
      sign_up:  'register'
    }

  root 'public#home'
  post 'skill_test', to: 'students#skill_test', as: 'skill_test'
  
  resources :students
  resources :confirmations

  namespace :backend do
    get "dashboard", to: 'home#dashboard', as: 'dashboard_admin'
    resources :admins
    resources :students do
      collection do
        get :multiple_action
        get :report
      end
    end
    resources :courses do
      collection do
        get :multiple_action
        get :report
      end
    end
    resources :confirmations do
      collection do
        get :multiple_action
        get :report
      end
    end
  end
end
