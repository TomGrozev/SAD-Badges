defmodule Badges.Repo.Migrations.ActivityTopics do
  use Ecto.Migration

  def change do
    alter table(:topics_completed) do
      add :activity_id, references(:activities)
    end
  end
end
