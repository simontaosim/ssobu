Rails.application.routes.draw do

  resources :product_intros

  resources :post_addresses

  resources :areas

  resources :cities

  resources :province_states

  resources :countries

  resources :planets

  resources :orders

  get 'sessions/auth_user_remote'

  get 'mobile_view', to: 'mobile_view#index'

  get 'mobile_view/login'

  get 'mobile_view/regist'

  get 'mobile_texts/send_sms'
  post 'mobile_texts/send_sms'
  resources :mobile_texts

  resources :products

  get 'personal/index'

  get 'personal/my_account'

  get 'personal/myorder'

  get 'personal/account_setting'

  resources :user_roles

  resources :roles

  resources :sessions

  resources :articles

  get 'users/new_register'

  post 'users/register'

  get 'users/username_is_exist'

  post 'users/username_is_exist'

  get 'users/email_is_exist'

  post 'users/email_is_exist'

   get 'users/mobile_is_exist'

  post 'users/mobile_is_exist'

  resources :nodes

  resources :users

  

  post 'sessions/create'

  mount WeixinRailsMiddleware::Engine, at: "/"
  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

end
