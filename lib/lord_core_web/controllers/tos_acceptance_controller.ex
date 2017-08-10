defmodule LordCoreWeb.TosAcceptanceController do
  use LordCoreWeb, :controller

  alias LordCore.StripeAccounts
  alias LordCore.StripeAccounts.TosAcceptance

  action_fallback LordCoreWeb.FallbackController

  def index(conn, _params) do
    tos_acceptances = StripeAccounts.list_tos_acceptances()
    render(conn, "index.json", tos_acceptances: tos_acceptances)
  end

  def create(conn, %{"tos_acceptance" => tos_acceptance_params}) do
    with {:ok, %TosAcceptance{} = tos_acceptance} <- StripeAccounts.create_tos_acceptance(tos_acceptance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tos_acceptance_path(conn, :show, tos_acceptance))
      |> render("show.json", tos_acceptance: tos_acceptance)
    end
  end

  def show(conn, %{"id" => id}) do
    tos_acceptance = StripeAccounts.get_tos_acceptance!(id)
    render(conn, "show.json", tos_acceptance: tos_acceptance)
  end

  def update(conn, %{"id" => id, "tos_acceptance" => tos_acceptance_params}) do
    tos_acceptance = StripeAccounts.get_tos_acceptance!(id)

    with {:ok, %TosAcceptance{} = tos_acceptance} <- StripeAccounts.update_tos_acceptance(tos_acceptance, tos_acceptance_params) do
      render(conn, "show.json", tos_acceptance: tos_acceptance)
    end
  end

  def delete(conn, %{"id" => id}) do
    tos_acceptance = StripeAccounts.get_tos_acceptance!(id)
    with {:ok, %TosAcceptance{}} <- StripeAccounts.delete_tos_acceptance(tos_acceptance) do
      send_resp(conn, :no_content, "")
    end
  end
end
