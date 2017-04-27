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

    resources "/stripe-accounts",
      StripeAccountController,
      only: [:new, :create, :show]

    resources "/companies", CompanyController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
