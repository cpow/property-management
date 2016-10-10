defmodule LordCore.Repo.Migrations.CreatePropertyManager do
  use Ecto.Migration

  def change do
    create table(:property_managers) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone_number, :string
      add :password_hash, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end
    create index(:property_managers, [:company_id])

  end
end
