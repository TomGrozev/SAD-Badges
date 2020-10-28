defmodule Badges.Repo.Migrations.TestTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :test_id, references(:tests, on_delete: :delete_all)
    end
  end
end
