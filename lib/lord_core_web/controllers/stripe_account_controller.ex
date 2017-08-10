defmodule LordCoreWeb.StripeAccountController do
  use LordCoreWeb, :controller
  alias LordCore.StripeAccount

  require IEx

  plug Guardian.Plug.EnsureAuthenticated, [handler: LordCore.AuthErrorHandler]

  def new(conn, _params, current_user) do
    conn
    |> render("new.html", %{user: current_user})
  end

  def create(conn, %{"data" => %{"attributes" => attrs}}, current_user) do
    public_token = attrs["public_token"]
    account_id = attrs["account_id"]
    public_endpoint = "https://sandbox.plaid.com/item/public_token/exchange"
    client_id = Application.get_env(:lord_core, :plaid)[:client_id]
    secret = Application.get_env(:lord_core, :plaid)[:secret]

    {_, args} = Poison.encode(%{client_id: client_id,
                              secret: secret,
                              public_token: public_token})

    headers = [{"Content-type", "application/json"}]

    case HTTPoison.request(:post, public_endpoint, args, headers) do
      {:ok, response} ->
        {_, decoded_body} = Poison.decode(response.body)
        token = decoded_body["access_token"]
    end

    {_, second_call_args} = Poison.encode(%{client_id: client_id,
                                            secret: secret,
                                            access_token: token,
                                            account_id: account_id
                                          })

    create_endpoint = "https://sandbox.plaid.com/processor/stripe/bank_account_token/create"

    case HTTPoison.request(:post, create_endpoint, second_call_args, headers) do
      {:ok, response} ->
        {_, decoded_body} = Poison.decode(response.body)

        request_id = decoded_body["request_id"]
        token = decoded_body["stripe_bank_account_token"]
    end

    account_data = %{request_id: request_id, stripe_bank_account_token: token}
    changeset = StripeAccount.changeset(%StripeAccount{}, account_data)

    case Repo.insert(changeset) do
      {:ok, stripe_account} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", stripe_account_path(conn, :show, stripe_account))
        |> render("show.json-api", data: stripe_account)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCoreWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def action(conn, _) do apply(__MODULE__, action_name(conn),
   [conn, conn.params, Guardian.Plug.current_resource(conn)])
  end
end
