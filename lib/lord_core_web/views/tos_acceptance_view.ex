defmodule LordCoreWeb.TosAcceptanceView do
  use LordCoreWeb, :view
  alias LordCoreWeb.TosAcceptanceView

  def render("index.json", %{tos_acceptances: tos_acceptances}) do
    %{data: render_many(tos_acceptances, TosAcceptanceView, "tos_acceptance.json")}
  end

  def render("show.json", %{tos_acceptance: tos_acceptance}) do
    %{data: render_one(tos_acceptance, TosAcceptanceView, "tos_acceptance.json")}
  end

  def render("tos_acceptance.json", %{tos_acceptance: tos_acceptance}) do
    %{id: tos_acceptance.id,
      date: tos_acceptance.date}
  end
end
