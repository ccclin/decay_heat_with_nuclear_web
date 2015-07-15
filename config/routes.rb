Rails.application.routes.draw do
  root 'decay_heat#index'
  get 'calculate' => 'decay_heat#calculate'
  post 'calculate' => 'decay_heat#calculate'
  # get 'download' => 'decay_heat#download'
  get 'show' => 'decay_heat#show'
end
