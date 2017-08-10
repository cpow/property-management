defmodule LordCore.Repo.Migrations.CreateTosAcceptances do
  use Ecto.Migration

  def change do
    create table(:tos_acceptances) do
      add :date, :utc_datetime
      add :ip, :string

      timestamps()
    end

  end
end
