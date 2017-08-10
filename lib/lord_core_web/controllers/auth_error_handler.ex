defmodule LordCoreWeb.AuthErrorHandler do
  use LordCoreWeb, :controller

  def unauthenticated(conn, _params) do
    conn
    |> json(%{"errors" => ["You must be an authenticated user to view this!"]})
    |> halt
  end
end

