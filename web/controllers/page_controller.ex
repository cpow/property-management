defmodule LordCore.PageController do
  use LordCore.Web, :controller

  def index(conn, _params) do
    IO.inspect(conn.assigns[:role])
    render conn, "index.html"
  end
end
