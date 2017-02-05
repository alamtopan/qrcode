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
  get 'process_attendance', to: 'public#process_attendance', as: 'process_attendance'

  namespace :backend do
    get "dashboard", to: 'home#dashboard', as: 'dashboard_admin'
    resources :admins
    resources :teachers do
      collection do
        get :multiple_action
      end
    end
    resources :students do
      collection do
        get :multiple_action
        get :report
      end
    end
    resources :attendances do
      collection do
        get :multiple_action
      end
    end
  end
end
