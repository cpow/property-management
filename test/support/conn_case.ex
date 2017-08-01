defmodule LordCore.Web.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias LordCore.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import LordCore.Factory

      import LordCore.Web.Router.Helpers

      # The default endpoint for testing
      @endpoint LordCore.Web.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(LordCore.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(LordCore.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()

    conn =
      unless tags[:no_user] do
        user = case tags[:role] do
          nil ->
            LordCore.Factory.insert(:user)
          role ->
            LordCore.Factory.insert(:user, role: role)
        end

        {:ok, token, _} = Guardian.encode_and_sign(user, :api)

        conn
          |> Guardian.Plug.api_sign_in(user)
          |> Plug.Conn.put_req_header("authorization", "Bearer #{token}")
      else
        conn
      end

    conn =
      conn
        |> Plug.Conn.put_req_header("accept", "application/vnd.api+json")
        |> Plug.Conn.put_req_header("content-type", "application/vnd.api+json")



    {:ok, conn: conn}
  end
end
