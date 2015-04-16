Rails.application.routes.draw do

<<<<<<< HEAD
  get 'error_report/with404'

  get 'error_report/with500'

  get 'error_report/with422'

  resources :withdraw_records

  resources :qrcodes

  resources :bank_cards

  get 'personal_center/withdraw'

  get 'personal_center/my_income'

  get 'personal_center/node_sessions'

  get 'personal_center/share_order'

  get 'personal_center/show_products'

  get 'personal_center/index'

  get 'personal_center', to: 'personal_center#index'

=======
  resources :bank_cards

  get 'personal_center/index'

>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  get 'personal_center/my_commission'

  get 'personal_center/apply_cash'

  post 'payment/to_pay'

  get 'payment/index'

  get 'payment/to_pay'

  get 'payment/pay_success'

<<<<<<< HEAD
  post 'payment/pay_success'

=======
>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  get 'payment/pay_fail'

  get 'payment/require_pay_back'

  resources :carts

  resources :catalogs

  resources :public_accounts

  resources :streets

  resources :accounts

  get 'admins', to: 'admins#index'

  get 'admins/product_admin'

  get 'admins/users_admin'

  get 'admins/order_admin'

  get 'admins/address_admin'

  get 'admins/role_admin'

  get 'admins/node_admin'

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

  post 'orders/delivery'

  post 'sessions/auth_user_remote'

  post 'admin_sessions/new'

  get 'admin_sessions/new'

  post 'admin_sessions/auth_admin_remote'

  get 'admin_sessions/destroy'

  post 'admin_sessions/destroy'

  get 'mobile_view/protocol'

  get 'mobile_view/about'

  get 'mobile_view/boss_school'

<<<<<<< HEAD
=======
  get 'mobile_view/about'

  get 'mobile_view/boss_school'

>>>>>>> c6fe1f39e8332af8f745c0def6da8431bbe15e1e
  get 'mobile_view/require_pay_back'

  get 'mobile_view/yeepay_school'

  post 'mobile_view/send_verifycode'

  get 'mobile_view/check_verifycode'

  post 'mobile_view/to_pay'

  get 'mobile_view/pay_success'

  get 'mobile_view/global_notice'
  post 'mobile_view/global_notice'

  post 'mobile_view/auth_login'

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

  get 'admins/new_register'

  post 'admins/new_register'

  post 'admins/register'

  get 'admins/register'

  post 'sessions/create'

  mount WeixinRailsMiddleware::Engine, at: "/"
  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

end
