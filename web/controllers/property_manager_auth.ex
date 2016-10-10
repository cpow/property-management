defmodule LordCore.PropertyManagerAuth do
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    case conn.assigns do
      %{current_property_manager: %LordCore.PropertyManager{}} ->
        conn
      _ ->
        manager_id = get_session(conn, :property_manager_id)
        manager = manager_id && repo.get(LordCore.PropertyManager, manager_id)
        assign(conn, :current_property_manager, manager)
    end
  end
end
