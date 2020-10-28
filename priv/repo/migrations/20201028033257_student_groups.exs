defmodule Badges.Repo.Migrations.StudentGroups do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :group_id, references(:groups)
    end
  end
end
