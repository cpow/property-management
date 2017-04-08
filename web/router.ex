defmodule LordCore.Router do
  use LordCore.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", LordCore do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    get "/users/me", UserController, :me, as: :user_me

    post "/login", SessionController, :create, as: :login

    resources "/users", UserController do
      resources "/stripe_accounts",
        StripeAccountController,
        only: [:new, :create]
    end
    resources "/companies", CompanyController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/property_management_dashboard",
      PropertyManagementDashboardController, only: [:index]
    resources "/tenant_dashboard",
      TenantDashboardController, only: [:index]
  end
end
