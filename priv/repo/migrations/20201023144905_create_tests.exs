defmodule Badges.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add :planned_date, :utc_datetime, null: true

      timestamps()
    end
  end
end
