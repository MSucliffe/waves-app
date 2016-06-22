Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
             controller: "clearance/passwords",
             only: [:create, :edit, :update]
  end

  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"

  constraints Clearance::Constraints::SignedIn.new(&:admin?) do
    root to: "admin/dashboards#show", as: :admin_root
  end

  constraints Clearance::Constraints::SignedIn.new do
    root to: "dashboards#show", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "pages#show", id: "home"
  end

  resources :registration_process, only: [:update] do
    collection do
      resource :prerequisites,
               only: [:show, :update],
               controller: "registration/prerequisites"
      resource :vessel_info,
               only: [:show, :update],
               controller: "registration/vessel_info"
      resource :owner_info,
               only: [:show, :update],
               controller: "registration/owner_info"
      resource :declaration,
               only: [:show, :update],
               controller: "registration/declaration"
      resource :payment,
               only: [:show, :update],
               controller: "registration/payment"
      resource :success,
               only: [:show, :update],
               controller: "registration/success"
    end
  end

  # overriding HighVoltage
  get "/pages/*id" => "pages#show", as: :page, format: false
end
