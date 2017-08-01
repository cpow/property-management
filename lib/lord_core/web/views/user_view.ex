defmodule LordCore.Web.UserView do
  use LordCore.Web, :view
  alias LordCore.Repo
  use JaSerializer.PhoenixView

  attributes [
    :name,
    :email,
    :role
  ]

  has_one :company,
    include: false,
    serializer:  LordCore.Web.CompanyView,
    type: "company",
    field: :company_id

  has_one :stripe_account,
    include: LordCore.Web.StripeAccountView

  def stripe_account(struct, conn) do
    case struct.stripe_account do
      %Ecto.Association.NotLoaded{} ->
        struct
        |> Ecto.assoc(:stripe_account)
        |> Repo.one
      other -> other
    end
  end

end
