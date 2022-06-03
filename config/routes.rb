Rails.application.routes.draw do
  get "administrateurs", to: "administrateurs#index"
  get "contracts/claim_contract/:id", to: "contracts#claim_contract"
  get "contracts/validate_contract/:id", to: "contracts#validate_contract"
  get "contracts/pay_contract/:id", to: "contracts#pay_contract"

  post "contact/send_contact", to: "contact#send_contact"
  post "contact/send_contact_app_aff", to: "contact#send_contact_app_aff"
  post "contact/send_contact_admin", to: "contact#send_contact_admin"

  resources :categories, :contracts, :gestionnaires, :apporteurs, :liaison_utilisateurs, :leads

  get "language_set/fr", to: "set_language#fr"
  get "language_set/en", to: "set_language#en"

  get "apporteurs/index"
  get "/registration/complete_registration", as: "registration_complete"

  get "/sign_in", as: "signin", to: "sessions#signin"
  get "/sign_out", as: "signout", to: "sessions#signout"
  get "/sign_up", as: "signup", to: "sessions#signup"
  get "auth/sign_in", to: "auth#signin"
  get "auth/sign_out", to: "auth#signout"

  get "apporteurs/:id/complete_account_edit", to: "apporteurs#complete_account_edit"
  put "apporteurs/complete_account/:id", to: "apporteurs#complete_account_edit"
  patch "apporteurs/:id/complete_account_update", to: "apporteurs#complete_account_update"
  post "apporteurs/complete_account/:id", to: "apporteurs#complete_account_update"

  get "users/show", to: "users#show"
  get "users/edit", to: "users#edit"
  get "users/update", to: "users#edit"

  get "users", to: "users#show"
  put "users", to: "users#update"
  patch "users/update", to: "users#update"

  get "home/not_logged"
  root to: "home#index"

  get "user_avatar/new"
  post "user_avatar/upload"

  # get 'apporteurs/:id/edit', to: 'apporteurs#edit', as: :edit_apporteur
  # patch 'apporteurs/:id', to: 'apporteurs#update'
end
