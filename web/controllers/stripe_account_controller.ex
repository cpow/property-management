defmodule LordCore.StripeAccountController do
  use LordCore.Web, :controller
  alias LordCore.StripeAccount
  require IEx

  plug Guardian.Plug.EnsureAuthenticated, [handler: LordCore.AuthErrorHandler]

  def new(conn, _params, current_user) do
    conn
    |> render("new.html", %{user: current_user})
  end

  def create(conn, %{"data" => %{"attributes" => attrs}}, current_user) do
    changeset = StripeAccount.changeset(%StripeAccount{}, attrs)

    case Repo.insert(changeset) do
      {:ok, stripe_account} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", stripe_account_path(conn, :show, stripe_account))
        |> render("show.json-api", data: stripe_account)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCore.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def action(conn, _) do apply(__MODULE__, action_name(conn),
   [conn, conn.params, Guardian.Plug.current_resource(conn)])
  end
end
