defmodule LordCore.PropertyManagementDashboardView do
  use LordCore.Web, :view

  alias LordCore.Repo
  alias LordCore.Company

  def company_for_user(user) do
    Repo.get(Company, user.company_id)
  end
end
