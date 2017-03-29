defmodule LordCore.Router do
  use LordCore.Web, :router

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", LordCore do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
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

  # scope "/", LordCore do
  #   pipe_through :browser # Use the default browser stack
  #
  #   get "/", PageController, :index
  #   resources "/users", UserController do
  #     resources "/stripe_accounts",
  #       StripeAccountController,
  #       only: [:new, :create]
  #   end
  #   resources "/companies", CompanyController
  #   resources "/sessions", SessionController, only: [:new, :create, :delete]
  #   resources "/property_management_dashboard",
  #     PropertyManagementDashboardController, only: [:index]
  #   resources "/tenant_dashboard",
  #     TenantDashboardController, only: [:index]
  # end

  # Other scopes may use custom stacks.
  # scope "/api", LordCore do
  #   pipe_through :api
  # end
end
