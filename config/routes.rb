Rails.application.routes.draw do
  root 'home#index'

  # для URL '/api/...'
  # scope 'api' do
  #   # Запит типу Get
  #   get   'get-response' => 'home#response'
  #   # Запит типу Post, якщо вхідне речення буде зберігатися
  #   post  'get-response' => 'home#post-response'
  # end
  #
  # # CRUD ресурс для навчального набору
  # resources :training_datum, except: [:update]
end
