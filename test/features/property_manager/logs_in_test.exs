defmodule LordCore.Features.PropertyManager.LogsInTest do
  use LordCore.ConnCase
  use Hound.Helpers
  hound_session

  test "logs in successfully", _ do
    user = insert(:user)

    navigate_to "/sessions/new"
    fill_field({:id, "email"}, user.email)
    fill_field({:id, "password"}, "something")
    click({:class, "btn-primary"})

    assert page_source =~ "Welcome Back! #{user.first_name}"
  end
end
