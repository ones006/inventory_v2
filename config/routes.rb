ActionController::Routing::Routes.draw do |map|

  map.resources :general_transactions, :member => { :detail => :get }

  map.resources :item_outs

  map.resources :item_ins

  map.resources :item_transfers

  map.resources :transaction_types

  map.resources :begining_balances

  map.resources :placements

  map.resources :plus

  map.resources :suppliers

  map.resources :warehouses, :member => { :plu_available => :get, :setdefault => :get, :setasdefault => :put } do |warehouse|
    warehouse.resources :locations
  end

  map.namespace(:reports) do |report|
    report.resources :on_hands
  end
  map.signin "signin", :controller => :user_sessions, :action => :new
  map.signout "signout", :controller => :user_sessions, :action => :destroy

  map.with_options(:controller => :pages, :action => :show) do |page|
    page.transactions 'transactions', :id => 'transactions'
    page.reports 'reports', :id => 'reports'
    page.administrations 'administrations', :id => 'administrations'
  end
  map.dashboard 'dashboard', :controller => :pages
  map.root :controller => :pages

  map.resources :user_sessions
  map.resources :items, :collection => { :lookup => :get }
  map.resources :categories, :member => {:items_for_begining_balance => :get} do |category|
    category.resources :items
  end
  map.resources :companies
  map.resources :users
  map.connect ':controller/:action.:format'
end
