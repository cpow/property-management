defmodule LordCoreWeb.ExternalAccountView do
  use LordCoreWeb, :view
  alias LordCoreWeb.ExternalAccountView

  def render("index.json", %{external_accounts: external_accounts}) do
    %{data: render_many(external_accounts, ExternalAccountView, "external_account.json")}
  end

  def render("show.json", %{external_account: external_account}) do
    %{data: render_one(external_account, ExternalAccountView, "external_account.json")}
  end

  def render("external_account.json", %{external_account: external_account}) do
    %{id: external_account.id,
      token: external_account.token}
  end
end
