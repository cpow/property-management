defmodule LordCoreWeb.AuthErrorHandler do
  use LordCoreWeb, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> json(%{"errors" => ["You must be an authenticated user to view this!"]})
    |> halt
  end
end

