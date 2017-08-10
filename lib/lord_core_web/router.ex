defmodule LordCoreWeb.Router do
  use LordCoreWeb, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", LordCoreWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    get "/users/me", UserController, :me, as: :user_me

    post "/login", SessionController, :create, as: :login

    resources "/stripe-accounts",
      StripeAccountController,
      only: [:new, :create, :show]

    resources "/legal_entities", LegalEntityController
    resources "/tos_acceptances", TosAcceptanceController
    resources "/accounts", AccountController
    resources "/external_accounts", ExternalAccountController

    resources "/companies", CompanyController
    resources "/properties", PropertyController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
