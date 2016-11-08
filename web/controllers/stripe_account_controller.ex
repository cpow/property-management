defmodule LordCore.StripeAccountController do
  use LordCore.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end
end
