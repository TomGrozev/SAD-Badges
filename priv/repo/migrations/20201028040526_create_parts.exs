defmodule Badges.Repo.Migrations.CreateParts do
  use Ecto.Migration

  def change do
    create table(:parts) do
      add :name, :string
      add :required, :boolean, default: false, null: false

      timestamps()
    end
  end
end
