defmodule LordCoreWeb.SessionView do
  use LordCore.Web, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end

  def render("login_failed.json", _) do
    %{errors: ["Invalid username/password combination!"]}
  end
end
