defmodule LordCore.StripeAccountController do
  use LordCore.Web, :controller
  require IEx

  def new(conn, _params) do
    user = conn.assigns.current_user
    conn
    |> render("new.html", %{user: user})
  end

  def create(conn, _params) do
    IEx.pry
  end
end
