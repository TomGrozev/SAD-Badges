defmodule Badges.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :datetime, :utc_datetime
      add :name, :string

      timestamps()
    end
  end
end
