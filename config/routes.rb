AtlysMobileApp::Engine.routes.draw do
  get 'admin/android', to: 'androids#index', as: 'android_index'

  post 'admin/android/render', to: 'androids#create', as: 'android_create'

end
