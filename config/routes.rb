Rails.application.routes.draw do
  root 'decay_heat#index'
  post 'calculate' => 'decay_heat#calculate'
  get 'download' => 'decay_heat#download'
end
