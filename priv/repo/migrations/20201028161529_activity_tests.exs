defmodule Badges.Repo.Migrations.ActivityTests do
  use Ecto.Migration

  def change do
    alter table(:tests_completed) do
      add :activity_id, references(:activities, on_delete: :nilify_all)
    end
  end
end
