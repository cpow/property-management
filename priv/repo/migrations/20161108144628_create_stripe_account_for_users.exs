defmodule LordCore.Repo.Migrations.CreateStripeAccountForUsers do
  use Ecto.Migration

  def change do
    create table(:stripe_accounts) do
      add :account_id, :string
      add :secret_key, :string
      add :publishable_key, :string
      add :managed, :boolean, default: true, null: false
      add :user_id, references(:users)

      timestamps()
    end
  end
end
