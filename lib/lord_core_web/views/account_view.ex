defmodule LordCoreWeb.AccountView do
  use LordCoreWeb, :view
  alias LordCoreWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      email: account.email,
      type: account.type,
      display_name: account.display_name}
  end
end
