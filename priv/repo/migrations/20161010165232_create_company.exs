defmodule LordCore.Repo.Migrations.CreateCompany do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :address, :string
      add :phone_number, :string

      timestamps()
    end

  end
end
