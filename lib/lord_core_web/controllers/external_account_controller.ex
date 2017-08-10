defmodule LordCoreWeb.ExternalAccountController do
  use LordCoreWeb, :controller

  alias LordCore.StripeAccounts
  alias LordCore.StripeAccounts.ExternalAccount

  action_fallback LordCoreWeb.FallbackController

  def index(conn, _params) do
    external_accounts = StripeAccounts.list_external_accounts()
    render(conn, "index.json", external_accounts: external_accounts)
  end

  def create(conn, %{"external_account" => external_account_params}) do
    with {:ok, %ExternalAccount{} = external_account} <- StripeAccounts.create_external_account(external_account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", external_account_path(conn, :show, external_account))
      |> render("show.json", external_account: external_account)
    end
  end

  def show(conn, %{"id" => id}) do
    external_account = StripeAccounts.get_external_account!(id)
    render(conn, "show.json", external_account: external_account)
  end

  def update(conn, %{"id" => id, "external_account" => external_account_params}) do
    external_account = StripeAccounts.get_external_account!(id)

    with {:ok, %ExternalAccount{} = external_account} <- StripeAccounts.update_external_account(external_account, external_account_params) do
      render(conn, "show.json", external_account: external_account)
    end
  end

  def delete(conn, %{"id" => id}) do
    external_account = StripeAccounts.get_external_account!(id)
    with {:ok, %ExternalAccount{}} <- StripeAccounts.delete_external_account(external_account) do
      send_resp(conn, :no_content, "")
    end
  end
end
