Rails.application.routes.draw do
  require 'subdomain'
  # require 'sidekiq/web'
  # mount Sidekiq::Web, at: '/sidekiq'
  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     resources :feedbacks, only: :create
  #     resources :mobile_users, only: [:update] do
  #       collection do
  #         post :referral
  #         post :register
  #         post :resend_otp
  #         post :login
  #         get :customer_details
  #         post :device_registration
  #       end

  #       member do
  #         post :authenticate_otp
  #       end
  #     end
  #     resources :complaints do
  #       collection do
  #         post :register
  #       end
  #     end
  #     resources :subscriptions, only: [:create, :update] do
  #       collection do
  #         post :customer_subscriptions
  #         post :renew
  #       end
  #       resources :subscription_pauses, only: [:create, :index]
  #     end

  #     resources :subscription_pauses, except: [:create, :index] do
  #       collection do
  #         get :customerwise
  #       end
  #     end

  #     resources :services do
  #       resources :packs, only: [:index] do
  #         resources :plans, only: [:index, :show]
  #       end
  #     end

  #     resources :lists do
  #       collection do
  #         get :categories
  #         get :countries
  #         get :states
  #         get :cities
  #         get :areas
  #         get :localities
  #         get :societies
  #         get :wings
  #         get :group_areas
  #       end
  #     end

  #     resources :faqs, only: [:index] do
  #       collection do
  #         get :categories
  #       end
  #     end
  #     resources :notifications, only: [:index, :show] do
  #       member do
  #         get :viewed
  #       end
  #     end
  #   end
  #   namespace :v2 do
  #     resources :feedbacks, only: :create
  #     resources :mobile_users, only: [:update] do
  #       collection do
  #         post :register
  #         post :resend_otp
  #         post :login
  #         get :customer_details
  #         post :device_registration
  #         get :auth_details
  #         post :number_available
  #       end

  #       member do
  #         post :authenticate_otp
  #       end
  #     end
  #     resources :complaints do
  #       collection do
  #         post :register
  #       end
  #     end
  #     resources :subscriptions, only: [:create, :update] do
  #       collection do
  #         post :customer_subscriptions
  #         post :renew
  #       end
  #       resources :subscription_pauses, only: [:create, :index]
  #     end

  #     resources :subscription_pauses, except: [:create, :index] do
  #       collection do
  #         get :customerwise
  #       end
  #     end

  #     resources :services do
  #       resources :packs, only: [:index] do
  #         resources :plans, only: [:index, :show]
  #       end
  #     end

  #     resources :lists do
  #       collection do
  #         get :categories
  #         get :countries
  #         get :states
  #         get :cities
  #         get :areas
  #         get :localities
  #         get :societies
  #         get :wings
  #         get :group_areas
  #       end
  #     end

  #     resources :faqs, only: [:index] do
  #       collection do
  #         get :categories
  #       end
  #     end
  #     resources :notifications, only: [:index, :show] do
  #       member do
  #         get :viewed
  #       end
  #     end
  #     resources :pay_u_money
  #     resources :payment_histories do
  #       collection do
  #         post :payu_details
  #       end
  #     end
  #   end
  # end

  scope '/admin' do
    devise_for :users
    devise_scope :user do
      get 'sign_in', to: 'devise/sessions#new'
      unauthenticated :user do
        root to: 'devise/sessions#new', as: :unauthenticated_root
      end
      authenticated :user do
        root to: 'orders#index', as: :authenticated_root
      end
    end

    # Routes for location management
    resources :wings do
      collection do
        get :list
      end
    end
    resources :societies do
      collection do
        get :list
        post 'Area', to: 'societies#create_area'
        post 'Locality', to: 'societies#create_locality'
      end
    end

    resources :localities do
      collection do
        get :list
      end
    end
    resources :areas do
      collection do
        get :list
      end
      member do
        get :delete
      end
    end
    resources :cities do
      collection do
        get :list
      end
      member do
        get :delete
      end
    end
    resources :states do
      collection do
        get :list
      end
      member do
        get :delete
      end
    end
    resources :countries do
      member do
        get :delete
      end
    end

    # Routes for service management
    resources :services
    resources :plan_products
    resources :packages
    resources :measurements
    resources :plans do
      collection do
        get :list
      end
      member do
        get :delete
      end
    end
    resources :packs
    resources :products do
      member do
        get :delete
      end
    end
    resources :orders do
      collection do
        get :excel
      end
      member do
        get :paid
      end
    end
    resources :locality_services

    # Routes For User Management
    resources :referrals
    resources :customers do
      get :search, on: :collection
      resources :subscriptions, except: [:index] do
        get :renew
        post :create_renew
      end
      resources :subscription_pauses
    end
    resources :payment_histories, only: [:edit, :update, :destroy]

    # Routes For FAQ
    resources :faq_questions
    resources :faq_categories do
      resources :faq_questions
    end

    # compalint
    resources :complaints
    resources :complaint_categories
    # feedback
    resources :feedback_categories
    resources :feedbacks
    # leads
    resources :leads, except: [:new, :create, :show]

    # invitations
    resources :invitations

    # notifications
    resources :custom_notifications

    # delivery
    resources :deliveries do
      collection do
        get :excel
      end
    end

    #domains
    resources :seasonal_domains
    constraints(Subdomain) do
      match '/' => 'home#index', via: :get
    end
  end

  # authenticated :user do
  root to: 'home#index'
  resources :home, only: [:index] do
    collection do
      post :create_order
      post :register_complaint
      post :calc_price
    end
  end

  # pay_u_money
  resources :pay_u_money, only: [:index]

  match '/payment_success' => 'pay_u_money#payu_success', :via => [:post]
  match '/payment_success' => 'pay_u_money#payu_success', :via => [:get]
  match '/payment_failure' => 'pay_u_money#payu_failure', :via => [:post]
  match '/payment_failure' => 'pay_u_money#payu_failure', :via => [:get]

  match '/payment' => 'pay_u_money#payu', :via => [:get]
  match '/export' => 'pay_u_money#export', :via => [:get]

  match '/complaint' => 'home#complaint', :via => [:get]
  match '/complaint_submitted' => 'home#complaint_submitted', :via => [:get]
  match '/cart' => 'home#cart', :via => [:get]
  match '/review/:id' => 'home#review', :via => [:get]
  match '/contact' => 'home#contact', :via => [:get]
  match '/policies' => 'home#policies', :via => [:get]
  match '/terms' => 'home#terms', :via => [:get]
  match '/selected_areas' => 'home#selected_areas', :via => [:get]

  # for site down path
  # root to: 'home#index'
  # get '*path', to: 'home#index'
end
