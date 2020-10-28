defmodule Badges.Repo.Migrations.TopicParts do
  use Ecto.Migration

  def change do
    alter table(:parts) do
      add :topic_id, references(:topics, on_delete: :delete_all)
    end
  end
end
