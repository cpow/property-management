defmodule LordCoreWeb.LegalEntityView do
  use LordCoreWeb, :view
  alias LordCoreWeb.LegalEntityView

  def render("index.json", %{legal_entities: legal_entities}) do
    %{data: render_many(legal_entities, LegalEntityView, "legal_entity.json")}
  end

  def render("show.json", %{legal_entity: legal_entity}) do
    %{data: render_one(legal_entity, LegalEntityView, "legal_entity.json")}
  end

  def render("legal_entity.json", %{legal_entity: legal_entity}) do
    %{id: legal_entity.id,
      first_name: legal_entity.first_name,
      last_name: legal_entity.last_name,
      type: legal_entity.type}
  end
end
