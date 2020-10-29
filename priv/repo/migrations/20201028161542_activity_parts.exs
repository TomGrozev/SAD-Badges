defmodule Badges.Repo.Migrations.ActivityParts do
  use Ecto.Migration

  def change do
    alter table(:parts_completed) do
      add :activity_id, references(:activities)
    end
  end
end
