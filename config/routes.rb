Rails.application.routes.draw do

  resources :bank_cards

  get 'personal_center/index'

  get 'personal_center/my_commission'

  get 'personal_center/apply_cash'

  post 'payment/to_pay'

  get 'payment/index'

  get 'payment/to_pay'

  get 'payment/pay_success'

  get 'payment/pay_fail'

  get 'payment/require_pay_back'

  resources :carts

  resources :catalogs

  resources :public_accounts

  resources :streets

  resources :accounts

  get 'admin', to: 'admin#index'

  get 'admin/product_admin'

  get 'admin/users_admin'

  get 'admin/order_admin'

  get 'admin/address_admin'

  get 'admin/role_admin'

  get 'admin/node_admin'

  resources :product_images

  resources :product_lines

  resources :product_intros

  resources :post_addresses

  resources :areas

  resources :cities

  resources :province_states

  resources :countries

  resources :planets

  resources :orders

  get 'sessions/auth_user_remote'

  get 'mobile_view/about'

  get 'mobile_view/boss_school'

  get 'mobile_view/require_pay_back'

  get 'mobile_view/yeepay_school'

  post 'mobile_view/send_verifycode'

  get 'mobile_view/check_verifycode'

  post 'mobile_view/to_pay'

  get 'mobile_view/pay_success'

  get 'mobile_view/global_notice'
  post 'mobile_view/global_notice'

  get 'mobile_view/product_apply'

  post 'mobile_view/on_product_apply'

  get 'mobile_view/order_confirm'

  post 'mobile_view/order_confirm'

  get 'mobile_view/address_confirm'

  post 'mobile_view/buy_where'

  get 'mobile_view/go_order'

  post 'mobile_view/go_order'

  get 'mobile_view/show_product'

  get 'mobile_view/dologin'

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
  
  get 'users/remote_register'

  post 'users/remote_register'

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
