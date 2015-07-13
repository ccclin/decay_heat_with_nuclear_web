Rails.application.routes.draw do
  root 'decay_heat#index'
  post 'calculate' => 'decay_heat#calculate'
  post 'xchange' => 'decay_heat#xchange'
end
