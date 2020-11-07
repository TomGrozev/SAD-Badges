defmodule Badges.Repo.Migrations.StudentGroups do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :group_id, references(:groups, on_delete: :nilify_all)
    end
  end
end
