defmodule LordCore.Repo.Migrations.CreateUniqueIndexesNeeded do
  use Ecto.Migration

  def change do
    create unique_index(:companies, [:name])
    create unique_index(:users, [:username, :email])
    create unique_index(:property_managers, [:email])
  end
end
