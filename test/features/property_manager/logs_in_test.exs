defmodule LordCore.Features.PropertyManager.LogsInTest do
  use LordCore.ConnCase
  use Hound.Helpers
  hound_session

  test "logs in successfully", _ do
    user = insert(:user)

    sign_in_as(user)

    assert page_source =~ "Welcome Back! #{user.first_name}"
  end

  test "sees their company after logging in" do
    role = insert(:role, name: "Property Manager")
    company = insert(:company)
    user = insert(:user, role: role, company: company)

    sign_in_as(user)

    assert page_source =~ "#{company.name}"
  end

  test "sees a list of properties the company has" do
    role = insert(:role, name: "Property Manager")
    company = insert(:company)
    property = insert(:property, company: company)
    user = insert(:user, role: role, company: company)

    sign_in_as(user)

    assert page_source =~ "#{property.name}"
  end

  def sign_in_as(user) do
    navigate_to "/sessions/new"
    fill_field({:id, "email"}, user.email)
    fill_field({:id, "password"}, "something")
    click({:class, "btn-primary"})
  end
end
