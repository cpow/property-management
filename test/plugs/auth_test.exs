defmodule LordCore.Plugs.AuthTest do
  use LordCore.ConnCase

  test "returns just the conn when user is already set" do
    user = insert(:user)

    conn = build_conn
    |> assign(:current_user, user)
    |> LordCore.Auth.call(LordCore.Repo)

    assert not_redirected?(conn)
  end

  defp not_redirected?(conn) do
    conn.status != 302
  end
end
