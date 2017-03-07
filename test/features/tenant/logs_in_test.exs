defmodule LordCore.Features.Tenant.LogsInTest do
  use LordCore.ConnCase
  use Hound.Helpers
  hound_session()

  test "logs in successfully", _ do
    role = insert(:role, name: "Tenant")
    property = insert(:property)
    user = insert(:user, role: role, property: property)

    sign_in_as(user)

    assert page_source() =~ "Welcome Back! #{user.first_name}"
    assert page_source() =~ "Current Property: #{property.name}"
  end

  def sign_in_as(user) do
    navigate_to "/sessions/new"
    fill_field({:id, "email"}, user.email)
    fill_field({:id, "password"}, "something")
    click({:class, "btn-primary"})
  end
end
